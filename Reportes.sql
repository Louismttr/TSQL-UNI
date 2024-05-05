USE msdb
GO

--Crear un nuevo JOB
DECLARE @jobId BINARY(16);
EXEC msdb.dbo.sp_add_job
	@job_name = N'BackupBikeStoresDatabase',
	@enabled = 1,
	@notify_level_eventlog = 0,
	@job_id = @jobid OUTPUT;
EXEC msdb.dbo.sp_add_jobserver
	@job_name =  N'BackupBikeStoresDatabase';

--Definir nuevo paso y su configuracion 
EXEC msdb.dbo.sp_add_jobstep
	@job_name = N'BackupBikeStoresDatabase',
	@step_name = N'FullBackupStep',
	@step_name = N'TSQL',
	@subsystem = N'EXEC xp_sqlmaint ''-S localhost -D BikeStores -BkUpDB "E:\Archivo.bak"''',
	@retry_attempts = 5,
	@retry_interval = 5;

-- Crear calendarizacion
EXEC msdb.dbo.sp_add_schedule
	@shedule_name = N'weeklyBackupShedule',
	@freq_type = 8,
	@freq_interval = 1,
	@freq_subday_type = 1,
	@freq_subday_interval = 1,
	@active_start_time = 235900,
	@freq_recurrence_factor = 1;

EXEC msdb.dbo.sp_attach_schedule
	@job_name = N'BackupBikeStoresDatabase',
	@shedule_name = N'WeeklyBackupSchedule';
go
/* 
Reporte General
*/