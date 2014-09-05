/****** Object:  StoredProcedure [dbo].[GetCO2Year]    Script Date: 08/31/2014 21:53:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCO2Year]
AS
BEGIN
	--当年第一天
	DECLARE @DAY_YEAR DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)
	--获取当年的碳排量 
	DECLARE @TOTAL FLOAT
	SELECT @TOTAL = SUM(C.Value)*0.785
	FROM ConsumptionData C
	WHERE DeviceID=388 AND ReadingDate BETWEEN @DAY_YEAR AND GETDATE()
	
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0
	
	SELECT @TOTAL
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetCO2Mouth]    Script Date: 08/31/2014 21:57:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCO2Mouth]
AS
BEGIN
	--当月第一天
	DECLARE @DAY_MOUTH DATETIME
	SET @DAY_MOUTH = CONVERT(VARCHAR(100), DATEADD(dd,-DAY(GETDATE())+1,GETDATE()),23)
	--获取一个月的碳排量
	DECLARE @TOTAL FLOAT
	SELECT @TOTAL = SUM(C.Value)*0.785
	FROM ConsumptionData C
	WHERE DeviceID=388 AND ReadingDate BETWEEN @DAY_MOUTH AND GETDATE()
	--过滤为空
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0
	SELECT @TOTAL
END
/****** Object:  StoredProcedure [dbo].[GetUtilities]    Script Date: 08/31/2014 21:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得今年的水电气
--1.Electricity==388,2.Water==373,3.Gas==358,4.LN2==361
ALTER PROCEDURE [dbo].[GetUtilities]
	@DeviceID INT
AS
BEGIN
	--今年第一天
	DECLARE @DAY_YEAR DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)
	--获取水电气
	DECLARE @TOTAL FLOAT
	SELECT @TOTAL = SUM(C.Value)
		FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_YEAR AND GETDATE()
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		
	SELECT @TOTAL
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesEnergy]    Script Date: 08/31/2014 21:58:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--能源消费明细
--1.Electricity==388,2.Water==373,3.Gas==358,4.LN2==361
ALTER PROCEDURE [dbo].[GetUtilitiesEnergy]
	@DeviceID INT
AS
BEGIN
	--今天
	DECLARE @DAY_TODAY DATETIME
	SET @DAY_TODAY = CONVERT(VARCHAR(100), DATEADD(dd,-DAY(GETDATE())+1,GETDATE()),23)
	--本周一
	DECLARE @DAY_WEEK DATETIME
	DECLARE @WEEKDAY INT
	SET @WEEKDAY = DATEPART(weekday,GETDATE())
	IF @WEEKDAY = 1
	BEGIN
		SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,7,getdate()),0)    
	END
	ELSE
		SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0)   
	--当月的第一天
	DECLARE @DAY_MONTH DATETIME
	SET @DAY_MONTH = DATEADD(mm, DATEDIFF(mm,0,DATEADD(mm, 0, GETDATE())), 0) 
	--当年的第一天
	DECLARE @DAY_YEAR DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,DATEADD(yy, 0, GETDATE())), 0)  	
	
	DECLARE @TOTAL_TODAY FLOAT
	DECLARE @TOTAL_WEEK FLOAT
	DECLARE @TOTAL_MONTH FLOAT
	DECLARE @TOTAL_YEAR FLOAT
	
	--Today
	SELECT @TOTAL_TODAY = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_TODAY AND GETDATE()
	IF @TOTAL_TODAY IS NULL
		SET @TOTAL_TODAY = 0
	--Week
	SELECT @TOTAL_WEEK = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_WEEK AND GETDATE()
	IF @TOTAL_WEEK IS NULL
		SET @TOTAL_WEEK = 0
	--Month
	SELECT @TOTAL_MONTH = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_MONTH AND GETDATE()
	IF @TOTAL_MONTH IS NULL
		SET @TOTAL_MONTH = 0
	--Year
	SELECT @TOTAL_YEAR = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_YEAR AND GETDATE()
	IF @TOTAL_YEAR IS NULL
		SET @TOTAL_YEAR = 0
		
	SELECT @TOTAL_TODAY AS 'Today',
	@TOTAL_WEEK AS 'WTD',
	@TOTAL_MONTH AS 'MTD',
	@TOTAL_YEAR AS 'YTD'
END
Go
/****** Object:  StoredProcedure [dbo].[GetUtilitiesPrev]    Script Date: 08/31/2014 21:58:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得去年的水电气
--1.Electricity==388,2.Water==373,3.Gas==358,4.LN2==361
ALTER PROCEDURE [dbo].[GetUtilitiesPrev]
	@DeviceID INT
AS
BEGIN
	--去年第一天
	DECLARE @DAY_YEAR_F DATETIME
	SET @DAY_YEAR_F = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)
	--去年最后一天
	DECLARE @DAY_YEAR_L DATETIME
	SET @DAY_YEAR_L = DATEADD(ms,-3,DATEADD(yy, DATEDIFF(yy,0,getdate()), 0))  
	--获取水电气
	DECLARE @TOTAL FLOAT
	SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0	
	SELECT @TOTAL
END
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesPrevMonths]    Script Date: 09/02/2014 11:18:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得去年12个月的水电气明细
--1.Electricity==388,2.Water==373,3.Gas==358,4.LN2==361
ALTER PROCEDURE [dbo].[GetUtilitiesPrevMonths]
	@DeviceID INT
AS
BEGIN
	--声明总数表
	DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)
	--去年第一天
	DECLARE @DAY_YEAR	DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)
	--获得选择月份数
	DECLARE @INDEX INT
	SET @INDEX = 0
	--每天的起始时间和结束时间
	DECLARE @MONTH_F	DATETIME
	DECLARE @MONTH_L	DATETIME
	DECLARE @TOTAL FLOAT
	--循环获得明细
	WHILE @INDEX < 12
	BEGIN
		SET @MONTH_F = DATEADD(mm,@INDEX,@DAY_YEAR)
		SET @MONTH_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_F))
		SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @MONTH_F AND @MONTH_L
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)
		SET @INDEX = @INDEX + 1
	END
	SELECT * FROM @TEMP_ENGERY
END
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesPrevMonths]    Script Date: 09/02/2014 11:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得去年给定月份的每天能源明细
ALTER PROCEDURE [dbo].[GetUtilitiesPrevDays]
	@DeviceID	INT,
	@Month		INT
AS
BEGIN
	--声明总数表
	DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)
	--去年第一天
	DECLARE @DAY_YEAR	DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)
	--选择的月份第一天
	DECLARE @MONTH_DAY DATETIME
	SET @MONTH_DAY = DATEADD(mm,@Month-1,@DAY_YEAR)
	--获得选择月份的天数
	DECLARE @COUNT	INT
	SET @COUNT	= DATEDIFF(dd,@MONTH_DAY,DATEADD(mm,@Month,@DAY_YEAR))
	DECLARE @INDEX INT
	SET @INDEX = 0
	--每天的起始时间和结束时间
	DECLARE @DAY_F	DATETIME
	DECLARE @DAY_L	DATETIME
	DECLARE @TOTAL  FLOAT
	WHILE @INDEX < @COUNT
	BEGIN
		SET @DAY_F = DATEADD(dd,@INDEX,@MONTH_DAY)
		SET @DAY_L = DATEADD(ms,-3,DATEADD(dd,1,@DAY_F))
		SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_F AND @DAY_L
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)
		SET @INDEX = @INDEX+1
	END
	SELECT * FROM @TEMP_ENGERY
END
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesPrevMonths]    Script Date: 09/02/2014 11:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得去年给定月份的每天能源明细
ALTER PROCEDURE [dbo].[GetUtilitiesPrevHours]
	@DeviceID	INT,
	@Month		INT,
	@Day		INT
AS
BEGIN
	--声明总数表
	DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)
	--去年第一天
	DECLARE @DAY_YEAR	DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)
	--选择的指定日期
	DECLARE @HOUR DATETIME
	SET @HOUR = DATEADD(dd,@Day-1,DATEADD(mm,@Month-1,@DAY_YEAR)) 
	DECLARE @INDEX INT
	SET @INDEX = 0
	--每天的起始时间和结束时间
	DECLARE @HOUR_F	DATETIME
	DECLARE @HOUR_L	DATETIME
	DECLARE @TOTAL FLOAT
	WHILE @INDEX < 24
	BEGIN
		SET @HOUR_F = DATEADD(hh,@INDEX,@HOUR)
		SET @HOUR_L = DATEADD(ms,-3,DATEADD(hh,1,@HOUR_F))
		SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)
		SET @INDEX = @INDEX+1
	END
	SELECT * FROM @TEMP_ENGERY
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetEquipmentEnergy]
	@DeviceID INT
AS
BEGIN
	--名称
	DECLARE @NAME NVARCHAR(510)
	SELECT @NAME = Name FROM dbo.ListOfDevices WHERE DeviceID = @DeviceID
	--去年第一天和最后一天
	DECLARE @DAY_YEAR_F DATETIME
	DECLARE @DAY_YEAR_L DATETIME
	SET @DAY_YEAR_F = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)
	SET @DAY_YEAR_L = DATEADD(ms,-3,DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0))  
	--今年的第一天
	DECLARE @DAY_YEAR DATETIME
	SET @DAY_YEAR =DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)
	--获得四个季度的开始和截止时间
	DECLARE @QUARTER_1_F DATETIME
	DECLARE @QUARTER_1_L DATETIME
	DECLARE @QUARTER_2_F DATETIME
	DECLARE @QUARTER_2_L DATETIME
	DECLARE @QUARTER_3_F DATETIME
	DECLARE @QUARTER_3_L DATETIME
	DECLARE @QUARTER_4_F DATETIME
	DECLARE @QUARTER_4_L DATETIME
	SET @QUARTER_1_F = @DAY_YEAR
	SET @QUARTER_2_F = DATEADD(qq,1,@QUARTER_1_F)
	SET @QUARTER_3_F = DATEADD(qq,1,@QUARTER_2_F)
	SET @QUARTER_4_F = DATEADD(qq,1,@QUARTER_3_F)
	SET @QUARTER_1_L = DATEADD(ms,-3,@QUARTER_2_F)
	SET @QUARTER_2_L = DATEADD(ms,-3,@QUARTER_3_F)
	SET @QUARTER_3_L = DATEADD(ms,-3,@QUARTER_4_F)
	SET @QUARTER_4_L = DATEADD(ms,-3,DATEADD(yy,1,@DAY_YEAR))
	--获得当前季度的3个月
	DECLARE @MONTH_1_F DATETIME
	DECLARE @MONTH_1_L DATETIME
	DECLARE @MONTH_2_F DATETIME
	DECLARE @MONTH_2_L DATETIME
	DECLARE @MONTH_3_F DATETIME
	DECLARE @MONTH_3_L DATETIME
	SET @MONTH_1_F = DATEADD(mm,3*(DATEPART(qq,GETDATE())-1),@DAY_YEAR)
	SET @MONTH_1_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_1_F))
	SET @MONTH_2_F = DATEADD(mm,1,@MONTH_1_F)
	SET @MONTH_2_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_2_F))
	SET @MONTH_3_F = DATEADD(mm,2,@MONTH_1_F)
	SET @MONTH_3_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_3_F))
	--获得当前月的各个星期
	DECLARE @WEEK_1_F DATETIME
	DECLARE @WEEK_1_L DATETIME
	DECLARE @WEEK_2_F DATETIME
	DECLARE @WEEK_2_L DATETIME
	DECLARE @WEEK_3_F DATETIME
	DECLARE @WEEK_3_L DATETIME
	DECLARE @WEEK_4_F DATETIME
	DECLARE @WEEK_4_L DATETIME
	SET @WEEK_1_F = DATEADD(mm, DATEDIFF(m,0,GETDATE()), 0)
	SET @WEEK_1_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_1_F))
	SET @WEEK_2_F = DATEADD(ww, 1, @WEEK_1_F)
	SET @WEEK_2_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_2_F))
	SET @WEEK_3_F = DATEADD(ww, 1, @WEEK_2_F)
	SET @WEEK_3_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))
	SET @WEEK_4_F = DATEADD(ww, 1, @WEEK_3_F)
	SET @WEEK_4_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))
	--获得各个时间段的值
	--今年的总数
	DECLARE @TOTAL FLOAT 
	SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID IN (390,391,392,393,394,395,396,397,398,399,400)
	AND (ReadingDate BETWEEN @DAY_YEAR AND GETDATE())
			
	--Previous Year
	DECLARE @TOTAL1 FLOAT 
	SELECT @TOTAL1 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L
	--Yearly Target
	DECLARE @TOTAL2 FLOAT 
	SET @TOTAL2 = 0.0 --定制目前空着
	--YTD
	DECLARE @TOTAL3 FLOAT 
	SELECT @TOTAL3 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @DAY_YEAR AND GETDATE())
	--%
	DECLARE @TOTAL4 FLOAT 
	SET @TOTAL4 = @TOTAL3/@TOTAL
	--Q1
	DECLARE @TOTAL5 FLOAT 
	SELECT @TOTAL5 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @QUARTER_1_F AND @QUARTER_1_L)
	--Q2
	DECLARE @TOTAL6 FLOAT 
	SELECT @TOTAL6 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @QUARTER_2_F AND @QUARTER_2_L)
	--Q3
	DECLARE @TOTAL7 FLOAT 
	SELECT @TOTAL7 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @QUARTER_3_F AND @QUARTER_3_L)
	--Q4
	DECLARE @TOTAL8 FLOAT 
	SELECT @TOTAL8 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @QUARTER_4_F AND @QUARTER_4_L)
	--Month1
	DECLARE @TOTAL9 FLOAT 
	SELECT @TOTAL9 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @MONTH_1_F AND @MONTH_1_L)
	--Month2
	DECLARE @TOTAL10 FLOAT 
	SELECT @TOTAL10 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @MONTH_2_F AND @MONTH_2_L)
	--Month3
	DECLARE @TOTAL11 FLOAT 
	SELECT @TOTAL11 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @MONTH_3_F AND @MONTH_3_L)
	--Week1
	DECLARE @TOTAL12 FLOAT 
	SELECT @TOTAL12 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @WEEK_1_F AND @WEEK_1_L)
	--Week2
	DECLARE @TOTAL13 FLOAT 
	SELECT @TOTAL13 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @WEEK_2_F AND @WEEK_2_L)
	--Week3
	DECLARE @TOTAL14 FLOAT 
	SELECT @TOTAL14 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @WEEK_3_F AND @WEEK_3_L)
	--Week4
	DECLARE @TOTAL15 FLOAT 
	SELECT @TOTAL15 = SUM(C.Value)
	FROM ConsumptionData C
	WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @WEEK_4_F AND @WEEK_4_L)
	
	SELECT
	@DeviceID AS 'DeviceID', 
	@NAME AS 'Name',
	@TOTAL1 AS 'PreviousYear',
	@TOTAL2 AS 'YearlyTarget',
	@TOTAL3 AS 'YTD',
	@TOTAL4 AS 'Percentage',
	@TOTAL5 AS 'Q1',
	@TOTAL6 AS 'Q2',
	@TOTAL7 AS 'Q3',
	@TOTAL8 AS 'Q4',
	@TOTAL9 AS 'Month1', 
	@TOTAL10 AS 'Month2',
	@TOTAL11 AS 'Month3',
	@TOTAL12 AS 'Week1',
	@TOTAL13 AS 'Week2',
	@TOTAL14 AS 'Week3',
	@TOTAL15 AS 'Week4',
	@TOTAL AS 'TotalYTD'
END
GO
--获得去年的水电气  
ALTER PROCEDURE [dbo].[GetAllEquipmentEnergy]  
AS
BEGIN
 --去年第一天和最后一天  
 DECLARE @DAY_YEAR_F DATETIME  
 DECLARE @DAY_YEAR_L DATETIME  
 SET @DAY_YEAR_F = DATEADD(yy, DATEDIFF(yy,0,GETDATE())-1, 0)  
 SET @DAY_YEAR_L = DATEADD(ms,-3,DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0))    
 --今年的第一天  
 DECLARE @DAY_YEAR DATETIME  
 SET @DAY_YEAR =DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)  
 --获得四个季度的开始和截止时间  
 DECLARE @QUARTER_1_F DATETIME  
 DECLARE @QUARTER_1_L DATETIME  
 DECLARE @QUARTER_2_F DATETIME  
 DECLARE @QUARTER_2_L DATETIME  
 DECLARE @QUARTER_3_F DATETIME  
 DECLARE @QUARTER_3_L DATETIME  
 DECLARE @QUARTER_4_F DATETIME  
 DECLARE @QUARTER_4_L DATETIME  
 SET @QUARTER_1_F = @DAY_YEAR  
 SET @QUARTER_2_F = DATEADD(qq,1,@QUARTER_1_F)  
 SET @QUARTER_3_F = DATEADD(qq,1,@QUARTER_2_F)  
 SET @QUARTER_4_F = DATEADD(qq,1,@QUARTER_3_F)  
 SET @QUARTER_1_L = DATEADD(ms,-3,@QUARTER_2_F)  
 SET @QUARTER_2_L = DATEADD(ms,-3,@QUARTER_3_F)  
 SET @QUARTER_3_L = DATEADD(ms,-3,@QUARTER_4_F)  
 SET @QUARTER_4_L = DATEADD(ms,-3,DATEADD(yy,1,@DAY_YEAR))  
 --获得当前季度的3个月  
 DECLARE @MONTH_1_F DATETIME  
 DECLARE @MONTH_1_L DATETIME  
 DECLARE @MONTH_2_F DATETIME  
 DECLARE @MONTH_2_L DATETIME  
 DECLARE @MONTH_3_F DATETIME  
 DECLARE @MONTH_3_L DATETIME  
 SET @MONTH_1_F = DATEADD(mm,3*(DATEPART(qq,GETDATE())-1),@DAY_YEAR)  
 SET @MONTH_1_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_1_F))  
 SET @MONTH_2_F = DATEADD(mm,1,@MONTH_1_F)  
 SET @MONTH_2_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_2_F))  
 SET @MONTH_3_F = DATEADD(mm,2,@MONTH_1_F)  
 SET @MONTH_3_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_3_F))  
 --获得当前月的各个星期  
 DECLARE @WEEK_1_F DATETIME  
 DECLARE @WEEK_1_L DATETIME  
 DECLARE @WEEK_2_F DATETIME  
 DECLARE @WEEK_2_L DATETIME  
 DECLARE @WEEK_3_F DATETIME  
 DECLARE @WEEK_3_L DATETIME  
 DECLARE @WEEK_4_F DATETIME  
 DECLARE @WEEK_4_L DATETIME  
 SET @WEEK_1_F = DATEADD(mm, DATEDIFF(m,0,GETDATE()), 0)  
 SET @WEEK_1_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_1_F))  
 SET @WEEK_2_F = DATEADD(ww, 1, @WEEK_1_F)  
 SET @WEEK_2_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_2_F))  
 SET @WEEK_3_F = DATEADD(ww, 1, @WEEK_2_F)  
 SET @WEEK_3_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))  
 SET @WEEK_4_F = DATEADD(ww, 1, @WEEK_3_F)  
 SET @WEEK_4_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))  
 --声明表变量  
 DECLARE @TEMP_ENERGY TABLE( 
	DeviceID INT, 
	Name VARCHAR(510),  
	PreviousYear FLOAT,  
	YearlyTarget FLOAT,  
	YTD FLOAT,  
	Percentage FLOAT,  
	Q1 FLOAT,  
	Q2 FLOAT,  
	Q3 FLOAT,  
	Q4 FLOAT,  
	Month1 FLOAT,  
	Month2 FLOAT,  
	Month3 FLOAT,  
	Week1 FLOAT,  
	Week2 FLOAT,  
	Week3 FLOAT,  
	Week4 FLOAT,  
	TotalYTD FLOAT   
 )  
 --获得各个时间段的值  
 DECLARE @TABLE TABLE(T INT)  
 INSERT INTO @TABLE(T) VALUES(390)  
 INSERT INTO @TABLE(T) VALUES(391)  
 INSERT INTO @TABLE(T) VALUES(392)  
 INSERT INTO @TABLE(T) VALUES(393)  
 INSERT INTO @TABLE(T) VALUES(394)  
 INSERT INTO @TABLE(T) VALUES(395)  
 INSERT INTO @TABLE(T) VALUES(396)  
 INSERT INTO @TABLE(T) VALUES(397)  
 INSERT INTO @TABLE(T) VALUES(398)  
 INSERT INTO @TABLE(T) VALUES(399)  
 INSERT INTO @TABLE(T) VALUES(400)  
	
 --今年的总数  
 DECLARE @TOTAL FLOAT   
 SELECT @TOTAL = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE DeviceID IN (390,391,392,393,394,395,396,397,398,399,400)  
 AND (ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
 --声明变量  
 DECLARE @SUM_TOTAL_1 FLOAT  
 DECLARE @SUM_TOTAL_2 FLOAT  
 DECLARE @SUM_TOTAL_3 FLOAT  
 DECLARE @SUM_TOTAL_5 FLOAT  
 DECLARE @SUM_TOTAL_6 FLOAT  
 DECLARE @SUM_TOTAL_7 FLOAT  
 DECLARE @SUM_TOTAL_8 FLOAT  
 DECLARE @SUM_TOTAL_9 FLOAT  
 DECLARE @SUM_TOTAL_10 FLOAT  
 DECLARE @SUM_TOTAL_11 FLOAT  
 DECLARE @SUM_TOTAL_12 FLOAT  
 DECLARE @SUM_TOTAL_13 FLOAT  
 DECLARE @SUM_TOTAL_14 FLOAT  
 DECLARE @SUM_TOTAL_15 FLOAT  
 SET @SUM_TOTAL_1 = 0  
 SET @SUM_TOTAL_2 = 0  
 SET @SUM_TOTAL_3 = 0  
 SET @SUM_TOTAL_5 = 0  
 SET @SUM_TOTAL_6 = 0  
 SET @SUM_TOTAL_7 = 0  
 SET @SUM_TOTAL_8 = 0  
 SET @SUM_TOTAL_9 = 0  
 SET @SUM_TOTAL_10 = 0  
 SET @SUM_TOTAL_11 = 0  
 SET @SUM_TOTAL_12 = 0  
 SET @SUM_TOTAL_13 = 0  
 SET @SUM_TOTAL_14 = 0  
 SET @SUM_TOTAL_15 = 0  
 --循环ID表  
 DECLARE @ID INT  
 DECLARE CURSOR1 CURSOR FOR SELECT * FROM @TABLE  
 OPEN CURSOR1  
 FETCH NEXT FROM CURSOR1 INTO @ID  
 WHILE (@@fetch_status=0)  
 BEGIN  
  --NAME  
  DECLARE @NAME NVARCHAR(510)  
  SELECT @NAME = Name FROM dbo.ListOfDevices WHERE DeviceID = @ID  
  --Previous Year  
  DECLARE @TOTAL1 FLOAT   
  SELECT @TOTAL1 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L)  
  IF @TOTAL1 IS NULL   
   SET @TOTAL1 = 0  
  SET @SUM_TOTAL_1 = @SUM_TOTAL_1+@TOTAL1  
  --Yearly Target  
  DECLARE @TOTAL2 FLOAT   
  SET @TOTAL2 = 0.0 --定制目前空着  
  SET @SUM_TOTAL_2 = 0.0  
  --YTD  
  DECLARE @TOTAL3 FLOAT   
  SELECT @TOTAL3 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
  IF @TOTAL3 IS NULL   
   SET @TOTAL3 = 0  
  SET @SUM_TOTAL_3 = @SUM_TOTAL_3+@TOTAL3  
  --%  
  DECLARE @TOTAL4 FLOAT   
  IF @TOTAL IS NULL  
   SET @TOTAL4 = 0  
  ELSE  
   SET @TOTAL4 = @TOTAL3/@TOTAL  
  --Q1  
  DECLARE @TOTAL5 FLOAT   
  SELECT @TOTAL5 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @QUARTER_1_F AND @QUARTER_1_L)  
  IF @TOTAL5 IS NULL   
   SET @TOTAL5 = 0  
  SET @SUM_TOTAL_5 = @SUM_TOTAL_5+@TOTAL5  
  --Q2  
  DECLARE @TOTAL6 FLOAT   
  SELECT @TOTAL6 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @QUARTER_2_F AND @QUARTER_2_L)  
  IF @TOTAL6 IS NULL   
   SET @TOTAL6 = 0  
  SET @SUM_TOTAL_6 = @SUM_TOTAL_6+@TOTAL6  
  --Q3  
  DECLARE @TOTAL7 FLOAT   
  SELECT @TOTAL7 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @QUARTER_3_F AND @QUARTER_3_L)  
  IF @TOTAL7 IS NULL   
   SET @TOTAL7 = 0  
  SET @SUM_TOTAL_7 = @SUM_TOTAL_7+@TOTAL7  
  --Q4  
  DECLARE @TOTAL8 FLOAT   
  SELECT @TOTAL8 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @QUARTER_4_F AND @QUARTER_4_L)  
  IF @TOTAL8 IS NULL   
   SET @TOTAL8 = 0  
  SET @SUM_TOTAL_8 = @SUM_TOTAL_8+@TOTAL8  
  --Month1  
  DECLARE @TOTAL9 FLOAT   
  SELECT @TOTAL9 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @MONTH_1_F AND @MONTH_1_L)  
  IF @TOTAL9 IS NULL   
   SET @TOTAL9 = 0  
  SET @SUM_TOTAL_9 = @SUM_TOTAL_9+@TOTAL9  
  --Month2  
  DECLARE @TOTAL10 FLOAT   
  SELECT @TOTAL10 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @MONTH_2_F AND @MONTH_2_L)  
  IF @TOTAL10 IS NULL   
   SET @TOTAL10 = 0  
  SET @SUM_TOTAL_10 = @SUM_TOTAL_10+@TOTAL10  
  --Month3  
  DECLARE @TOTAL11 FLOAT   
  SELECT @TOTAL11 = SUM(C.Value)  
  FROM ConsumptionData C  
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @MONTH_3_F AND @MONTH_3_L)  
  IF @TOTAL11 IS NULL   
   SET @TOTAL11 = 0  
  SET @SUM_TOTAL_11 = @SUM_TOTAL_11+@TOTAL11  
  --Week1  
  DECLARE @TOTAL12 FLOAT   
  SELECT @TOTAL12 = SUM(C.Value)  
	FROM ConsumptionData C
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @WEEK_1_F AND @WEEK_1_L)  
  IF @TOTAL12 IS NULL   
   SET @TOTAL12 = 0  
  SET @SUM_TOTAL_12 = @SUM_TOTAL_12+@TOTAL12  
  --Week2  
  DECLARE @TOTAL13 FLOAT   
  SELECT @TOTAL13 = SUM(C.Value)  
	FROM ConsumptionData C
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @WEEK_2_F AND @WEEK_2_L)  
  IF @TOTAL13 IS NULL   
   SET @TOTAL13 = 0  
  SET @SUM_TOTAL_13 = @SUM_TOTAL_13+@TOTAL13  
  --Week3  
  DECLARE @TOTAL14 FLOAT   
  SELECT @TOTAL14 = SUM(C.Value)  
	FROM ConsumptionData C
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @WEEK_3_F AND @WEEK_3_L)  
  IF @TOTAL14 IS NULL   
   SET @TOTAL14 = 0  
  SET @SUM_TOTAL_14 = @SUM_TOTAL_14+@TOTAL14  
  --Week4  
  DECLARE @TOTAL15 FLOAT   
  SELECT @TOTAL15 = SUM(C.Value)  
	FROM ConsumptionData C
  WHERE DeviceID = @ID  
  AND (ReadingDate BETWEEN @WEEK_4_F AND @WEEK_4_L)  
  IF @TOTAL15 IS NULL   
   SET @TOTAL15 = 0  
  SET @SUM_TOTAL_15 = @SUM_TOTAL_15+@TOTAL15  
			
  INSERT INTO @TEMP_ENERGY VALUES(
  @ID,
  @NAME,  
  @TOTAL1,  
  @TOTAL2,  
  @TOTAL3,  
  @TOTAL4,  
  @TOTAL5,  
  @TOTAL6,  
  @TOTAL7,  
  @TOTAL8,  
  @TOTAL9,  
  @TOTAL10,  
  @TOTAL11,  
  @TOTAL12,  
  @TOTAL13,  
  @TOTAL14,  
  @TOTAL15,  
  0)  
			
 FETCH NEXT FROM CURSOR1 INTO @ID  
 END  
 CLOSE CURSOR1  
 DEALLOCATE CURSOR1  
 DELETE @TABLE  
	
 INSERT INTO @TEMP_ENERGY VALUES(
 -1,
 'Total',  
 @SUM_TOTAL_1,  
 @SUM_TOTAL_2,  
 @SUM_TOTAL_3,  
 0,  
 @SUM_TOTAL_5,  
 @SUM_TOTAL_6,  
 @SUM_TOTAL_7,  
 @SUM_TOTAL_8,  
 @SUM_TOTAL_9,  
 @SUM_TOTAL_10,  
 @SUM_TOTAL_11,  
 @SUM_TOTAL_12,  
 @SUM_TOTAL_13,  
 @SUM_TOTAL_14,  
 @SUM_TOTAL_15,  
 0)  
			
 SELECT * FROM @TEMP_ENERGY  
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Dept. Equipment Energy Efficiency模块  
ALTER PROCEDURE [dbo].[GetEquipmentEnergyEfficiency]  
 @DeviceID INT,  
 @Benchmark INT,  
 @PreviousYear FLOAT,  
 @YTD FLOAT,  
 @Q1 FLOAT,  
 @Q2 FLOAT,  
 @Q3 FLOAT,  
 @Q4 FLOAT,  
 @Month1 FLOAT,  
 @Month2 FLOAT,  
 @Month3 FLOAT,  
 @Week1 FLOAT,  
 @Week2 FLOAT,  
 @Week3 FLOAT,  
 @Week4 FLOAT  
AS  
BEGIN  
 DECLARE @DAY_YEAR DATETIME  
 SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()),0)  
 --去年的天数  
 DECLARE @DAY_YEAR_NUM INT  
 SET @DAY_YEAR_NUM = 365   
 --YTD天数  
 DECLARE @DAY_YTD_NUM INT  
 SET @DAY_YTD_NUM = DATEDIFF(dd,@DAY_YEAR,GETDATE())  
 --Q1天数  
 DECLARE @DAY_Q1_NUM INT  
 SET @DAY_Q1_NUM = DATEDIFF(dd,@DAY_YEAR,DATEADD(qq,1,@DAY_YEAR))  
 --Q2天数  
 DECLARE @DAY_Q2_NUM INT  
 SET @DAY_Q2_NUM = DATEDIFF(dd,DATEADD(qq,1,@DAY_YEAR),DATEADD(qq,2,@DAY_YEAR))  
 --Q3天数  
 DECLARE @DAY_Q3_NUM INT  
 SET @DAY_Q3_NUM = DATEDIFF(dd,DATEADD(qq,2,@DAY_YEAR),DATEADD(qq,3,@DAY_YEAR))  
 --Q3天数  
 DECLARE @DAY_Q4_NUM INT  
 SET @DAY_Q4_NUM = DATEDIFF(dd,DATEADD(qq,3,@DAY_YEAR),DATEADD(qq,4,@DAY_YEAR))  
 --Month1  
 DECLARE @DAY_MONTH_1_NUM INT  
 DECLARE @DAY_MONTH_1 DATETIME  
    SET @DAY_MONTH_1 = DATEADD(mm,3*(DATEPART(qq,GETDATE())-1),@DAY_YEAR)  
    SET @DAY_MONTH_1_NUM = DATEDIFF(dd,@DAY_MONTH_1,DATEADD(mm,1,@DAY_MONTH_1))  
 --Month2  
 DECLARE @DAY_MONTH_2_NUM INT  
 SET @DAY_MONTH_2_NUM = DATEDIFF(dd,DATEADD(mm,1,@DAY_MONTH_1),DATEADD(mm,2,@DAY_MONTH_1))  
 --Month3  
 DECLARE @DAY_MONTH_3_NUM INT  
 SET @DAY_MONTH_3_NUM = DATEDIFF(dd,DATEADD(mm,2,@DAY_MONTH_1),DATEADD(mm,3,@DAY_MONTH_1))  
 --Week  
 DECLARE @DAY_WEEK_NUM INT  
 SET @DAY_WEEK_NUM = 7    
 --获取数据  
 DECLARE @TEMP_ENERGY TABLE(  
  Name VARCHAR(510),  
  PreviousYear FLOAT,  
  YTD FLOAT,  
  Q1 FLOAT,  
  Q2 FLOAT,  
  Q3 FLOAT,  
  Q4 FLOAT,  
  Month1 FLOAT,  
  Month2 FLOAT,  
  Month3 FLOAT,  
  Week1 FLOAT,  
  Week2 FLOAT,  
  Week3 FLOAT,  
  Week4 FLOAT  
 )  
 --Equipment Quantity定值后续会提供  
 INSERT INTO @TEMP_ENERGY VALUES('Equipment Quantity',  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220,  
  220)  
 --Capacity Factor定值后续会提供  
 INSERT INTO @TEMP_ENERGY VALUES('Capacity Factor',  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91,  
  0.91)  
 --Consumption – Goal  
 INSERT INTO @TEMP_ENERGY VALUES('Consumption – Goal',  
  @Benchmark*0.91*220*@DAY_YEAR_NUM,  
  @Benchmark*0.91*220*@DAY_YTD_NUM,  
  @Benchmark*0.91*220*@DAY_Q1_NUM,  
  @Benchmark*0.91*220*@DAY_Q2_NUM,  
  @Benchmark*0.91*220*@DAY_Q3_NUM,  
  @Benchmark*0.91*220*@DAY_Q4_NUM,  
  @Benchmark*0.91*220*@DAY_MONTH_1_NUM,  
  @Benchmark*0.91*220*@DAY_MONTH_2_NUM,  
  @Benchmark*0.91*220*@DAY_MONTH_3_NUM,  
  @Benchmark*0.91*220*@DAY_WEEK_NUM,  
  @Benchmark*0.91*220*@DAY_WEEK_NUM,  
  @Benchmark*0.91*220*@DAY_WEEK_NUM,  
  @Benchmark*0.91*220*@DAY_WEEK_NUM)  
 --Consumption – Actual  
 INSERT INTO @TEMP_ENERGY VALUES('Consumption – Actual',  
  @PreviousYear,  
  @YTD,  
  @Q1,  
  @Q2,  
  @Q3,  
  @Q4,  
  @Month1,  
  @Month2,  
  @Month3,  
  @Week1,  
  @Week2,  
  @Week3,  
  @Week4)  
 --Efficiency  
 INSERT INTO @TEMP_ENERGY VALUES('Efficiency',
	CONVERT(decimal(18,2),@PreviousYear/(@Benchmark*0.91*220*@DAY_YEAR_NUM)),
	CONVERT(decimal(18,2),@YTD/(@Benchmark*0.91*220*@DAY_YTD_NUM)),
	CONVERT(decimal(18,2),@Q1/(@Benchmark*0.91*220*@DAY_Q1_NUM)),
	CONVERT(decimal(18,2),@Q2/(@Benchmark*0.91*220*@DAY_Q2_NUM)),
	CONVERT(decimal(18,2),@Q3/(@Benchmark*0.91*220*@DAY_Q3_NUM)),
	CONVERT(decimal(18,2),@Q4/(@Benchmark*0.91*220*@DAY_Q4_NUM)),
	CONVERT(decimal(18,2),@Month1/(@Benchmark*0.91*220*@DAY_MONTH_1_NUM)),
	CONVERT(decimal(18,2),@Month2/(@Benchmark*0.91*220*@DAY_MONTH_2_NUM)),
	CONVERT(decimal(18,2),@Month3/(@Benchmark*0.91*220*@DAY_MONTH_3_NUM)),
	CONVERT(decimal(18,2),@Week1/(@Benchmark*0.91*220*@DAY_WEEK_NUM)),
	CONVERT(decimal(18,2),@Week2/(@Benchmark*0.91*220*@DAY_WEEK_NUM)),
	CONVERT(decimal(18,2),@Week3/(@Benchmark*0.91*220*@DAY_WEEK_NUM)),
	CONVERT(decimal(18,2),@Week4/(@Benchmark*0.91*220*@DAY_WEEK_NUM))
	)
    
 SELECT * FROM @TEMP_ENERGY  
END
/****** Object:  StoredProcedure [dbo].[GetUtilitiesMonths]    Script Date: 09/02/2014 14:37:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得截止到现在的每个月水电气明细
ALTER PROCEDURE [dbo].[GetUtilitiesMonths]
	@DeviceID INT
AS
BEGIN
	--声明总数表
	DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)
	--今年第一天
	DECLARE @DAY_YEAR	DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)
	--获得选择月份数
	DECLARE @INDEX INT
	SET @INDEX = 0
	--每天的起始时间和结束时间
	DECLARE @MONTH_F	DATETIME
	DECLARE @MONTH_L	DATETIME
	DECLARE @TOTAL FLOAT
	--循环获得明细
	WHILE @INDEX < 12
	BEGIN
		SET @MONTH_F = DATEADD(mm,@INDEX,@DAY_YEAR)
		SET @MONTH_L = DATEADD(ms,-3,DATEADD(mm,1,@MONTH_F))
		SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @MONTH_F AND @MONTH_L
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)
		SET @INDEX = @INDEX + 1
	END
	SELECT * FROM @TEMP_ENGERY
END
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesDays]    Script Date: 09/02/2014 14:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得今年给定月份的每天能源明细  
ALTER PROCEDURE [dbo].[GetUtilitiesDays]  
 @DeviceID INT,  
 @Month  INT  
AS  
BEGIN  
 --声明总数表  
 DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)  
 --去年第一天  
 DECLARE @DAY_YEAR DATETIME  
 SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)  
 --选择的月份第一天  
 DECLARE @MONTH_DAY DATETIME  
 SET @MONTH_DAY = DATEADD(mm,@Month-1,@DAY_YEAR)  
 --获得选择月份的天数  
 DECLARE @COUNT INT  
 SET @COUNT = DATEDIFF(dd,@MONTH_DAY,DATEADD(mm,@Month,@DAY_YEAR))  
 DECLARE @INDEX INT  
 SET @INDEX = 0  
 --每天的起始时间和结束时间  
 DECLARE @DAY_F DATETIME  
 DECLARE @DAY_L DATETIME  
 DECLARE @TOTAL FLOAT  
 WHILE @INDEX < @COUNT  
 BEGIN  
  SET @DAY_F = DATEADD(dd,@INDEX,@MONTH_DAY)  
  SET @DAY_L = DATEADD(ms,-3,DATEADD(dd,1,@DAY_F))  
  SELECT @TOTAL = SUM(C.Value)  
	FROM ConsumptionData C
  WHERE DeviceID=@DeviceID AND ReadingDate BETWEEN @DAY_F AND @DAY_L  
  IF @TOTAL IS NULL  
   SET @TOTAL = 0.0  
  INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)  
  SET @INDEX = @INDEX+1  
 END  
 SELECT * FROM @TEMP_ENGERY  
END  
GO
/****** Object:  StoredProcedure [dbo].[GetUtilitiesHours]    Script Date: 09/02/2014 14:38:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获得今年给定月份的每天能源明细
ALTER PROCEDURE [dbo].[GetUtilitiesHours]
	@DeviceID	INT,
	@Month		INT,
	@Day		INT
AS
BEGIN
	--声明总数表
	DECLARE @TEMP_ENGERY TABLE(TOTAL FLOAT)
	--去年第一天
	DECLARE @DAY_YEAR	DATETIME
	SET @DAY_YEAR = DATEADD(yy, DATEDIFF(yy,0,GETDATE()), 0)
	--选择的指定日期
	DECLARE @HOUR DATETIME
	SET @HOUR = DATEADD(dd,@Day-1,DATEADD(mm,@Month-1,@DAY_YEAR)) 
	DECLARE @INDEX INT
	SET @INDEX = 0
	--每天的起始时间和结束时间
	DECLARE @HOUR_F	DATETIME
	DECLARE @HOUR_L	DATETIME
	DECLARE @TOTAL FLOAT
	WHILE @INDEX < 24
	BEGIN
		SET @HOUR_F = DATEADD(hh,@INDEX,@HOUR)
		SET @HOUR_L = DATEADD(ms,-3,DATEADD(hh,1,@HOUR_F))
		SELECT @TOTAL = SUM(C.Value)
	FROM ConsumptionData C
		WHERE DeviceID=@DeviceID AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		INSERT INTO @TEMP_ENGERY VALUES(@TOTAL)
		SET @INDEX = @INDEX+1
	END
	SELECT * FROM @TEMP_ENGERY
END
GO
--Equipment Energy Efficiency模块      
ALTER PROCEDURE [dbo].[GetChillerEnergyEfficiency]      
AS      
BEGIN      
       
 DECLARE @TEMP_ENERGY TABLE(      
  Name VARCHAR(510),      
  Chiller1 FLOAT,      
  Chiller2 FLOAT,      
  Chiller3 FLOAT,      
  Chiller4  FLOAT,      
  Chiller5 FLOAT      
 )      
 --Nominal Power       
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Nominal Power',      
  0,      
  505,      
  505,      
  608,      
  785      
 )      
 --Nominal CC      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Nominal CC',      
  0,      
  2700,      
  2700,      
  3516,      
  4570      
 )      
 --Normal COP      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Nominal COP',      
  0,      
  5.34,      
  5.34,      
  5.78,      
  5.82      
 )      
 DECLARE @HOUR_F DATETIME      
 DECLARE @HOUR_L DATETIME      
 SET @HOUR_F = DATEADD(hh, DATEDIFF(hh,0,GETDATE())-1,0)      
 SET @HOUR_L = DATEADD(ms, -3,DATEADD(hh,1,@HOUR_F))      
 DECLARE @Chiller1_1 FLOAT      
 DECLARE @Chiller2_1 FLOAT      
 DECLARE @Chiller3_1 FLOAT      
 DECLARE @Chiller4_1 FLOAT      
 --Actual Electricity Consumption      
 SELECT @Chiller1_1 = SUM(C.Value)      
 FROM ConsumptionData C        
 WHERE DeviceID=127   AND ReadingDate BETWEEN @HOUR_F AND @HOUR_L      
 IF @Chiller1_1 IS NULL      
  SET @Chiller1_1 = 0      
 SELECT @Chiller2_1 = SUM(C.Value)      
 FROM ConsumptionData C        
 WHERE DeviceID=125   AND ReadingDate BETWEEN @HOUR_F AND @HOUR_L      
 IF @Chiller2_1 IS NULL      
  SET @Chiller2_1 = 0      
 SELECT @Chiller3_1 = SUM(C.Value)      
 FROM ConsumptionData C        
 WHERE DeviceID=128   AND ReadingDate BETWEEN @HOUR_F AND @HOUR_L      
 IF @Chiller3_1 IS NULL      
  SET @Chiller3_1 = 0      
 SELECT @Chiller4_1 = SUM(C.Value)      
 FROM ConsumptionData C        
 WHERE DeviceID=167   AND ReadingDate BETWEEN @HOUR_F AND @HOUR_L      
 IF @Chiller4_1 IS NULL      
  SET @Chiller4_1 = 0      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual Electricity Consumption',      
  @Chiller1_1,      
  @Chiller2_1,      
  @Chiller3_1,      
  @Chiller4_1,      
  0      
 )      
 --Actual Accumulation Cooling       
 DECLARE @Chiller1_2 FLOAT      
 DECLARE @Chiller2_2 FLOAT      
 DECLARE @Chiller3_2 FLOAT      
 DECLARE @Chiller4_2 FLOAT      
 SELECT @Chiller1_2 = (SUM(C.Value)*284.43)    
 FROM ConsumptionData C        
 WHERE DeviceID=401 AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)      
 IF @Chiller1_2 IS NULL      
  SET @Chiller1_2 = 0      
 SELECT @Chiller2_2 = (SUM(C.Value)*284.43)      
 FROM ConsumptionData C        
 WHERE DeviceID=403   AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)      
 IF @Chiller2_2 IS NULL      
  SET @Chiller2_2 = 0      
 SELECT @Chiller3_2 = (SUM(C.Value)*284.43)      
 FROM ConsumptionData C        
 WHERE DeviceID=404   AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)      
 IF @Chiller3_2 IS NULL      
  SET @Chiller3_2 = 0      
 SELECT @Chiller4_2 = (SUM(C.Value)*284.43)    
 FROM ConsumptionData C        
 WHERE DeviceID=402   AND (ReadingDate BETWEEN @HOUR_F AND @HOUR_L)      
 IF @Chiller4_2 IS NULL      
  SET @Chiller4_2 = 0      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual Accumulation Cooling',      
  @Chiller1_2,      
  @Chiller2_2,      
  @Chiller3_2,      
  @Chiller4_2,      
  0      
 )      
 --Actual COP      
 DECLARE @COP_1 FLOAT    
 DECLARE @COP_2 FLOAT    
 DECLARE @COP_3 FLOAT    
 DECLARE @COP_4 FLOAT    
 IF @Chiller1_1 = 0    
 SET @COP_2 = 0    
 ELSE    
 SET @COP_2 = (@Chiller1_2*1000)/(@Chiller1_1*3.6)    
 IF @Chiller2_1 = 0    
 SET @COP_2 = 0    
 ELSE    
 SET @COP_2 = (@Chiller2_2*1000)/(@Chiller2_1*3.6)    
 IF @Chiller3_1 = 0    
 SET @COP_3 = 0    
 ELSE    
 SET @COP_3 = (@Chiller3_2*1000)/(@Chiller3_1*3.6)    
 IF @Chiller4_1 = 0    
 SET @COP_4 = 0    
 ELSE    
 SET @COP_4 = (@Chiller4_2*1000)/(@Chiller4_1*3.6)     
     
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual COP',      
  @COP_1,      
  @COP_2,      
  @COP_3,      
  @COP_4,      
  0      
 )      
 --Actual COP      
 DECLARE @Chiller1_COP FLOAT      
 DECLARE @Chiller2_COP FLOAT      
 DECLARE @Chiller3_COP FLOAT      
 DECLARE @Chiller4_COP FLOAT      
 IF @Chiller1_1 = 0      
  SET @Chiller1_COP = 0      
 ELSE      
  SET @Chiller1_COP = (@Chiller1_2*1000)/(@Chiller1_1*3.6)      
        
 IF @Chiller2_1 = 0      
  SET @Chiller2_COP = 0      
 ELSE      
  SET @Chiller2_COP = (@Chiller2_2*1000)/(@Chiller2_1*3.6)      
        
 IF @Chiller3_1 = 0      
  SET @Chiller3_COP = 0      
 ELSE      
  SET @Chiller3_COP = (@Chiller3_2*1000)/(@Chiller3_1*3.6)      
        
 IF @Chiller4_1 = 0      
  SET @Chiller4_COP = 0      
 ELSE      
  SET @Chiller4_COP = (@Chiller4_2*1000)/(@Chiller4_1*3.6)      
    
 --Actual VS Nominal COP      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual VS Nominal COP',      
  @Chiller1_COP/100,      
  @Chiller2_COP/100,      
  @Chiller3_COP/100,      
  @Chiller4_COP/100,      
  0      
 )      
 --BaseLine      
 INSERT INTO @TEMP_ENERGY VALUES(      
  'BaseLine',      
  1,      
  1,      
  1,      
  1,      
  1      
 )      
     
 SELECT * FROM @TEMP_ENERGY    
END