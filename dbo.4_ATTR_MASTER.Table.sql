USE [Navtech]
GO
/****** Object:  Table [dbo].[4_ATTR_MASTER]    Script Date: 03-11-2022 11:23:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[4_ATTR_MASTER](
	[AAID] [int] IDENTITY(1,1) NOT NULL,
	[LID] [int] NULL,
	[AANAME] [nvarchar](255) NULL,
	[AAVALUE] [nvarchar](255) NULL,
	[REMARK] [nvarchar](255) NULL,
	[CreatedDate] [date] NULL,
	[CreatedIP] [time](4) NULL,
	[UpdatedDate] [time](4) NULL,
	[UpdatedIP] [time](4) NULL,
	[is_removed] [bit] NULL,
	[is_hold] [bit] NULL,
	[hold_rmk] [nvarchar](max) NULL,
 CONSTRAINT [PK_4_ATTR_MASTER] PRIMARY KEY CLUSTERED 
(
	[AAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
