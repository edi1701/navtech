USE [Navtech]
GO
/****** Object:  Table [dbo].[2_SIZE_MASTER]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[2_SIZE_MASTER](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[SNAME] [nvarchar](max) NULL,
	[SDETAILS] [nvarchar](255) NULL,
	[SDESCRIPTION] [nvarchar](max) NULL,
	[REMARK] [nvarchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedIP] [nvarchar](20) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedIP] [nvarchar](20) NULL,
	[is_removed] [bit] NULL,
	[is_hold] [bit] NULL,
	[hold_rmk] [nvarchar](max) NULL,
 CONSTRAINT [PK_2_SIZE_MASTER] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
