USE [Navtech]
GO
/****** Object:  Table [dbo].[6_ORDER_MASTER]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[6_ORDER_MASTER](
	[ORID] [int] IDENTITY(1,1) NOT NULL,
	[ORGRPID] [nvarchar](255) NULL,
	[UserID] [nvarchar](255) NULL,
	[LID] [nvarchar](255) NULL,
	[QUANTITY] [smallint] NULL,
	[UnitPrice] [nvarchar](255) NULL,
	[FinalPrice] [nvarchar](255) NULL,
	[REMARK] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedIP] [nvarchar](20) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedIP] [nvarchar](20) NULL,
	[is_removed] [bit] NULL,
	[is_order_cancelled] [bit] NULL,
	[canc_details] [nvarchar](255) NULL,
 CONSTRAINT [PK_6_ORDER_MASTER] PRIMARY KEY CLUSTERED 
(
	[ORID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
