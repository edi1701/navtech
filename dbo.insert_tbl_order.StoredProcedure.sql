USE [Navtech]
GO
/****** Object:  StoredProcedure [dbo].[insert_tbl_order]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insert_tbl_order]
 @ORID int 
,@UserID nvarchar(255) 
,@ORGRPID nvarchar(255) 
,@STRJSON varchar(max) = ''
,@quantity smallint
,@createdip nvarchar(50)
,@Type nvarchar(10) = ''
,@Remarks nvarchar(255) 
as
begin TRY
	begin tran t1
		declare @SPNAME varchar(50)= (SELECT OBJECT_NAME(@@PROCID) )
	IF(@Type='INSERT')
	BEGIN 
   IF(@STRJSON<>'')
   BEGIN
   set @STRJSON =  REPLACE(@STRJSON,'\"','"')
   SELECT 
    MAX(CASE WHEN name='ORGRPID' THEN CONVERT(varchar(150),StringValue) ELSE '-' END) AS ORGRPID 
    ,MAX(CASE WHEN name='LID' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS LID 
    ,MAX(CASE WHEN name='QUANTITY' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS QUANTITY 
    ,MAX(CASE WHEN name='UnitPrice' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS UnitPrice 
    ,MAX(CASE WHEN name='FinalPrice' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS FinalPrice 
    ,MAX(CASE WHEN name='REMARK' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS REMARK 
   INTO  #tempJsonList FROM parseJSON(@STRJSON) 
   WHERE ValueType = 'string' OR ValueType = 'int' GROUP BY parent_ID
   
   IF(select count(1) from #tempJsonList) > 0
   BEGIN
     INSERT INTO [dbo].[6_ORDER_MASTER]
     ([ORGRPID]
     ,[UserID]
     ,[LID]
     ,[QUANTITY]
     ,[UnitPrice]
     ,[FinalPrice]
     ,[REMARK]
     ,[CreatedDate]
     ,[CreatedIp])
     select [ORGRPID],@UserID
     ,[LID]
     ,[QUANTITY]
     ,[UnitPrice]
     ,[FinalPrice]
     ,[REMARK]
     ,GETDATE()
     ,@CreatedIP
     from #tempJsonList    
   select 1 as Counts,'Order Details saved successfully' as Msg
   END
  DROP TABLE #tempJsonList  
  END
  ELSE
   BEGIN
    UPDATE [dbo].[6_ORDER_MASTER]
    SET  
     is_order_cancelled='1'
     ,canc_details=@Remarks
     ,updatedIP=@CreatedIP
     ,updatedDate=GETDATE()
    WHERE
    Userid=@UserID  and ORGRPID=@ORGRPID AND isnull(is_removed,0)!=1
    select 1 as Counts,'Order Cancelled successfully' as Msg
   END
	 END
	 ELSE IF(@Type='UPDATE')
	BEGIN 
   IF(@STRJSON<>'')
   BEGIN
   set @STRJSON =  REPLACE(@STRJSON,'\"','"')
   SELECT 
    MAX(CASE WHEN name='ORGRPID' THEN CONVERT(varchar(150),StringValue) ELSE '-' END) AS ORGRPID 
    ,MAX(CASE WHEN name='LID' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS LID 
    ,MAX(CASE WHEN name='QUANTITY' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS QUANTITY 
    ,MAX(CASE WHEN name='UnitPrice' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS UnitPrice 
    ,MAX(CASE WHEN name='FinalPrice' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS FinalPrice 
    ,MAX(CASE WHEN name='REMARK' THEN CONVERT(smallint,StringValue) ELSE '-' END) AS REMARK 
   INTO  #tempJsonList1 FROM parseJSON(@STRJSON) 
   WHERE ValueType = 'string' OR ValueType = 'int' GROUP BY parent_ID
   
   IF(select count(1) from #tempJsonList1) > 0
   BEGIN
   DECLARE @id1 int
DECLARE @id2 varchar(100)

DECLARE cur CURSOR FOR SELECT ORGRPID as id1,LID as id2 FROM #tempJsonList1
OPEN cur

FETCH NEXT FROM cur INTO @id1, @id2

	WHILE @@FETCH_STATUS = 0 BEGIN
	IF(SELECT count(1) FROM [dbo].[6_ORDER_MASTER] a inner join #tempJsonList1 b on a.UserID=b.UserID and a.ORGRPID=b.ORGRPID and a.LID=b.LID )=0 
    BEGIN
     update [dbo].[6_ORDER_MASTER]
      set      [QUANTITY]=b.[QUANTITY]
     ,[UnitPrice]=b.[UnitPrice]
     ,[FinalPrice]=b.[FinalPrice]
     ,[REMARK]=b.[REMARK]
     from [6_ORDER_MASTER] a
     inner join #tempJsonList1 b on a.UserID=b.UserID and a.ORGRPID=b.ORGRPID and a.LID=b.LID
   select 1 as Counts,'Order Details updated successfully' as Msg
   END
   ELSE 
		BEGIN
			INSERT INTO [dbo].[6_ORDER_MASTER]
     ([ORGRPID]
     ,[UserID]
     ,[LID]
     ,[QUANTITY]
     ,[UnitPrice]
     ,[FinalPrice]
     ,[REMARK]
     ,[CreatedDate]
     ,[CreatedIp])
     select [ORGRPID],@UserID
     ,[LID]
     ,[QUANTITY]
     ,[UnitPrice]
     ,[FinalPrice]
     ,[REMARK]
     ,GETDATE()
     ,@CreatedIP
     from #tempJsonList    where ORGRPID =@id1 and LID=@id1 and userid=@UserID 
		END
    FETCH NEXT FROM cur INTO @id1, @id2
END

CLOSE cur    
DEALLOCATE cur
   select 1 as Counts,'Order Details saved successfully' as Msg
   
   END
  DROP TABLE #tempJsonList1  
  END
	 END
	commit tran t1
end try
BEGIN CATCH 

		INSERT INTO [dbo].[ProcdureErrorLog]([ErrorTime],[UserName],[ErrorNumber],[ErrorProcedure],[ErrorLine],[ErrorMessage],SPName)
		VALUES(getdate(),@ORID, ERROR_NUMBER(), ERROR_PROCEDURE(),  ERROR_LINE(), ERROR_MESSAGE(),@SPNAME)
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
		select 0 as counts
END CATCH
GO
