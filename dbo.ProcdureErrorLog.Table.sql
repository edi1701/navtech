USE [Navtech]
GO
/****** Object:  Table [dbo].[ProcdureErrorLog]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcdureErrorLog](
	[ErrorTime] [datetime] NOT NULL,
	[UserName] [nvarchar](128) NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorProcedure] [nvarchar](126) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [nvarchar](4000) NOT NULL,
	[SPName] [varchar](500) NULL
) ON [PRIMARY]
GO
