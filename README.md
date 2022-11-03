# navtech

Product Category Master: dbo.0_CATG_MASTER.Table
ITEM MASTER:_ dbo.0_ITEM_MASTER.Table
COLOR MASTER:_ dbo.1_COLOR_MASTER.Table
SIZE MASTER:_ dbo.2_SIZE_MASTER.Table
Attributes: -dbo.3_ATTR_MASTER.Table

•	Number – Numeric values like Product Quantity Count
•	Text – Short descriptions like Product Name
•	Text Area – Long text like Product Description
•	File – File size values like Product Document
•	Image – Image type, image size, etc.
•	Identifiers – Unique value attributes related to product identification
•	Metrics – Product weight, power, height, width, capacity, etc.
•	Price – Product price, special price, offer price type attributes, etc.
•	Select & Multi-select – Ability to choose multiple options in attributes like color, size, etc.
•	Radio – Radio attributes are used to create value attributes.
•	Date – Product manufacture date, launch date, etc.

ADDITIONAL ATTRIBUTES MASTER:- dbo.4_ATTR_MASTER.Table

LISTING ITEMS:- dbo.5_ITEMLISTING.Table

ORDER MASTER:- dbo.6_ORDER_MASTER.Table


SP-

dbo.insert_tbl_order.StoredProcedure
dbo.ProcdureErrorLog.Table
dbo.select_tbl_order.StoredProcedure
