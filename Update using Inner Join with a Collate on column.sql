
BEGIN TRAN
Update T2 Set T2.DefaultValue = T1.DefaultValue  from [DATABASE1].[dbo].[LocalisationKeys]  T1
 inner join [DATABASE12].[dbo].[LocalisationKeys] T2
 ON (T1.[Key] COLLATE Latin1_General_CI_AS  = T2.[Key])

 --Commit
 --RollBack