USE [Navtech]
GO
/****** Object:  StoredProcedure [dbo].[select_tbl_order]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_tbl_order]
 @ORID int 
,@UserID nvarchar(255) 
,@LID int 
,@quantity smallint
,@createdip nvarchar(50)
,@Type nvarchar(10) = ''
,@Remarks nvarchar(255) 
as
begin TRY
	begin tran t1
		declare @SPNAME varchar(50)= (SELECT OBJECT_NAME(@@PROCID) )
	IF(@Type='SELECT')
	BEGIN
			select * from [dbo].[6_ORDER_MASTER] 
				WHERE ORID=@ORID and  isnull(is_removed,0)!=1  
	END
	ELSE IF(@Type='SELECTADMIN')
	BEGIN
			select c.PNAME,b.LPRICE,a.quantity,e.SNAME,d.CNAME
			,[Manufacturer]      ,[CountryofOrigin]      ,[manufactureyear]
      ,[MaterialComposition]      ,[Height]      ,[Weight]
      ,[FormFactor]      ,[Model]      ,[Recommendation]      ,[Importer]      ,[ASIN]
			,e.Createddate from [dbo].[6_ORDER_MASTER]  a
			inner join [dbo].[5_ITEMLISTING] b on a.LID=b.LID and  isnull(b.is_removed,0)!=1 
			inner join [dbo].[0_ITEM_MASTER] c on b.PID=c.PID and  isnull(c.is_removed,0)!=1 
			inner join [dbo].[1_COLOR_MASTER] d on b.CID=d.CID and  isnull(d.is_removed,0)!=1 
			inner join [dbo].[2_SIZE_MASTER] e on b.SID=e.SID and  isnull(e.is_removed,0)!=1 
			left outer join [dbo].[3_ATTR_MASTER] f on b.AID=f.AID and  isnull(f.is_removed,0)!=1 
				WHERE ORID=@ORID and  isnull(a.is_removed,0)!=1  
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
