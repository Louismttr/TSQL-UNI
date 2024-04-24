USE msdb
GO

--Crear un nuevo JOB
DECLARE @jobId BINARY(16);
EXEC msdb.dbo.sp_add_job
	@job_name = N'NorthwindDatabase',
	@enabled = 1,
	@notify_level_eventlog = 0,
	@job_id = @jobid OUTPUT;
EXEC msdb.dbo.sp_add_jobserver
	@job_name =  N'NorthwindDatabase';

--Definir nuevo paso y su configuracion 
EXEC msdb.dbo.sp_add_jobstep
	@job_name = N'NorthwindDatabase',
	@step_name = N'FullBackupStep',
	@subsystem = N'TSQL',
	@command = N'EXEC xp_sqlmaint ''-S localhost -D Northwind -BkUpDB "E:\BACKUPS.bak"''',
	@retry_attempts = 5,
	@retry_interval = 5;

-- Crear calendarizacion
EXEC msdb.dbo.sp_add_schedule
	@schedule_name = N'WeeklyBackupShedule',
	@freq_type = 8,
	@freq_interval = 1,
	@freq_subday_type = 1,
	@freq_subday_interval = 1,
	@active_start_time = 185500, --horaminutosegundos
	@freq_recurrence_factor = 1;
EXEC msdb.dbo.sp_attach_schedule
	@job_name = N'NorthwindDatabase',
	@schedule_name = N'WeeklyBackupShedule';
GO


/***Creación del plan de mantenimiento****/
DECLARE @jobId uniqueidentifier;
SELECT @jobId= job_id
	from dbo.sysjobs
Where name = 'NorthwindDatabase'

select * from sysjobs
---creando el plna de mantenimiento
DECLARE @myplan_id uniqueidentifier;
EXEC dbo.sp_add_maintenance_plan N'PlanMantenimientoNorthwindIL:3',
@plan_id= @myplan_id output;

--Vincular el plan de mantenimiento con el job

EXEC sp_add_maintenance_plan_job @plan_id = @myplan_id, @job_id=@jobId;

--Vincular el plan de mantenimiento con la BD BikeStore
EXEC sp_add_maintenance_plan_db @myplan_id, N'Northwind';

--Listar toda la información de los planes de mantenimiento 
--Con T-sql
select * from dbo.sysdbmaintplans;

select * from dbo.sysdbmaintplan_databases

-- para borrar el plan de mantenimiento
delete from dbo.sysdbmaintplan_databases where database_name = N'Northwind'
delete from dbo.sysdbmaintplans
where plan_name =	N'PlanMantenimientoNorthwindIL:3'

/* 
Reporte General
*/