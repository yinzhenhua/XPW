﻿/****** Object:  StoredProcedure [dbo].[GetCO2Year]    Script Date: 08/31/2014 21:53:52 ******/
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
	WHERE C.DeviceID=388 AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0
	--去除小数
	SELECT ROUND(@TOTAL,0)
	
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
	WHERE C.DeviceID=388 AND C.ReadingDate BETWEEN @DAY_MOUTH AND GETDATE()
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	--过滤为空
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0
	--去除小数	
	SELECT ROUND(@TOTAL,0)
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
		WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE()
		AND C.Tariffnum = 0 
		AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
	--去除小数	
	SELECT ROUND(@TOTAL,0)
		
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
	SET @DAY_TODAY = CONVERT(VARCHAR(100),GETDATE(),23)
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
	WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_TODAY AND GETDATE()
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	IF @TOTAL_TODAY IS NULL
		SET @TOTAL_TODAY = 0
	--Week
	SELECT @TOTAL_WEEK = SUM(C.Value)
	FROM ConsumptionData C
	WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_WEEK AND GETDATE()
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	IF @TOTAL_WEEK IS NULL
		SET @TOTAL_WEEK = 0
	--Month
	SELECT @TOTAL_MONTH = SUM(C.Value)
	FROM ConsumptionData C
	WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_MONTH AND GETDATE()
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	IF @TOTAL_MONTH IS NULL
		SET @TOTAL_MONTH = 0
	--Year
	SELECT @TOTAL_YEAR = SUM(C.Value)
	FROM ConsumptionData C
	WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE()
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	IF @TOTAL_YEAR IS NULL
		SET @TOTAL_YEAR = 0
	--去除小数点
	SELECT ROUND(@TOTAL_TODAY,0) AS 'Today',
	ROUND(@TOTAL_WEEK,0) AS 'WTD',
	ROUND(@TOTAL_MONTH,0) AS 'MTD',
	ROUND(@TOTAL_YEAR,0) AS 'YTD'
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
	WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L
	AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
	IF @TOTAL IS NULL
		SET @TOTAL = 0.0
	--去除小数点	
	SELECT ROUND(@TOTAL,0)
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
		WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @MONTH_F AND @MONTH_L
		AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		--去除小数点	
		SET @TOTAL = ROUND(@TOTAL,0)
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
		WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_F AND @DAY_L
		AND C.Tariffnum = 0 
	AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		--去除小数点	
		SET @TOTAL = ROUND(@TOTAL,0)
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
		WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @HOUR_F AND @HOUR_L)
		AND C.Tariffnum = 0 
		AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		--去除小数点	
		SET @TOTAL = ROUND(@TOTAL,0)
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
 @DeviceID	INT,
 @DeviceID1 INT  
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
 DECLARE @DAY_YEAR_CURT_L DATETIME
 SET @DAY_YEAR_CURT_L = DATEADD(ms,-3,DATEADD(yy,1,@DAY_YEAR))
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
  DECLARE @DAY_WEEK    DATETIME--当前周的周一  
  IF DATEPART(weekday,GETDATE()) = 1  
  SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,7,getdate()),0)      
  ELSE  
  SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0)    
  DECLARE @WEEK_1_F DATETIME    
  DECLARE @WEEK_1_L DATETIME    
  DECLARE @WEEK_2_F DATETIME    
  DECLARE @WEEK_2_L DATETIME    
  DECLARE @WEEK_3_F DATETIME    
  DECLARE @WEEK_3_L DATETIME    
  DECLARE @WEEK_4_F DATETIME    
  DECLARE @WEEK_4_L DATETIME    
  DECLARE @WEEK_5_F DATETIME    
  DECLARE @WEEK_5_L DATETIME    
  DECLARE @WEEK_6_F DATETIME    
  DECLARE @WEEK_6_L DATETIME    
  SET @WEEK_1_F = DATEADD(mm, DATEDIFF(m,0,GETDATE()), 0)--第一周第一天  
  SET @WEEK_1_L = DATEADD(ms,-3,DATEADD(dd,9-DATEPART(weekday,@WEEK_1_F),@WEEK_1_F))--第一周最后一天    
  SET @WEEK_2_F = DATEADD(dd,1,DATEADD(dd,8-DATEPART(weekday,@WEEK_1_F),@WEEK_1_F))--第二周第一天   
  SET @WEEK_2_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_2_F))    
  SET @WEEK_3_F = DATEADD(ww, 1, @WEEK_2_F)    
  SET @WEEK_3_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))    
  SET @WEEK_4_F = DATEADD(ww, 1, @WEEK_3_F)    
  SET @WEEK_4_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_4_F))   
  SET @WEEK_5_F = DATEADD(ww, 1, @WEEK_4_F)  
  SET @WEEK_5_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_5_F))   
  SET @WEEK_6_F = DATEADD(ww, 1, @WEEK_5_F)     
  SET @WEEK_6_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_6_F))    
 --获得各个时间段的值  
 --今年的总数  
 DECLARE @TOTAL FLOAT   
 SELECT @TOTAL = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID IN (390,391,392,393,394,395,396,397,398,399,400)  
 AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 --Previous Year  
 DECLARE @TOTAL1 FLOAT   
 SELECT @TOTAL1 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL1 IS NULL  
  SET @TOTAL1 = 0  
 --Yearly Target  
 DECLARE @TOTAL2 FLOAT   
 SELECT @TOTAL2 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID1 
 AND (C.ReadingDate BETWEEN @DAY_YEAR AND @DAY_YEAR_CURT_L)  
 AND C.Tariffnum = 0   
 IF @TOTAL2 IS NULL  
  SET @TOTAL2 = 0    
 --YTD  
 DECLARE @TOTAL3 FLOAT   
 SELECT @TOTAL3 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL3 IS NULL  
  SET @TOTAL3 = 0  
 --%  
 DECLARE @TOTAL4 FLOAT   
 SET @TOTAL4 = @TOTAL3/@TOTAL  
 --Q1  
 DECLARE @TOTAL5 FLOAT   
 SELECT @TOTAL5 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @QUARTER_1_F AND @QUARTER_1_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL5 IS NULL  
  SET @TOTAL5 = 0  
 --Q2  
 DECLARE @TOTAL6 FLOAT   
 SELECT @TOTAL6 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @QUARTER_2_F AND @QUARTER_2_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL6 IS NULL  
  SET @TOTAL6 = 0  
 --Q3  
 DECLARE @TOTAL7 FLOAT   
 SELECT @TOTAL7 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @QUARTER_3_F AND @QUARTER_3_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL7 IS NULL  
  SET @TOTAL7 = 0  
 --Q4  
 DECLARE @TOTAL8 FLOAT   
 SELECT @TOTAL8 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @QUARTER_4_F AND @QUARTER_4_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL8 IS NULL  
  SET @TOTAL8 = 0  
 --Month1  
 DECLARE @TOTAL9 FLOAT   
 SELECT @TOTAL9 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @MONTH_1_F AND @MONTH_1_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL9 IS NULL  
  SET @TOTAL9 = 0  
 --Month2  
 DECLARE @TOTAL10 FLOAT   
 SELECT @TOTAL10 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @MONTH_2_F AND @MONTH_2_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL10 IS NULL  
  SET @TOTAL10 = 0  
 --Month3  
 DECLARE @TOTAL11 FLOAT   
 SELECT @TOTAL11 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @MONTH_3_F AND @MONTH_3_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL11 IS NULL  
  SET @TOTAL11 = 0  
 --Week1  
 DECLARE @TOTAL12 FLOAT   
 SELECT @TOTAL12 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_1_F AND @WEEK_1_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL12 IS NULL  
  SET @TOTAL12 = 0  
 --Week2  
 DECLARE @TOTAL13 FLOAT   
 SELECT @TOTAL13 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_2_F AND @WEEK_2_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL13 IS NULL  
  SET @TOTAL13 = 0  
 --Week3  
 DECLARE @TOTAL14 FLOAT   
 SELECT @TOTAL14 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_3_F AND @WEEK_3_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL14 IS NULL  
  SET @TOTAL14 = 0  
 --Week4  
 DECLARE @TOTAL15 FLOAT   
 SELECT @TOTAL15 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_4_F AND @WEEK_4_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL15 IS NULL  
  SET @TOTAL15 = 0  
 --Week5  
 DECLARE @TOTAL16 FLOAT   
 SELECT @TOTAL16 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_5_F AND @WEEK_5_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL16 IS NULL  
  SET @TOTAL16 = 0  
 --Week6  
 DECLARE @TOTAL17 FLOAT   
 SELECT @TOTAL17 = SUM(C.Value)  
 FROM ConsumptionData C  
 WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @WEEK_6_F AND @WEEK_6_L)  
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)  
 IF @TOTAL17 IS NULL  
  SET @TOTAL17 = 0  
 --去除小数点   
 SELECT  
 @DeviceID AS 'DeviceID',   
 @NAME AS 'Name',  
 ROUND(@TOTAL1,0) AS 'PreviousYear',  
 ROUND(@TOTAL2,0) AS 'YearlyTarget',  
 ROUND(@TOTAL3,0) AS 'YTD',  
 ROUND(@TOTAL4,3) AS 'Percentage',  
 ROUND(@TOTAL5,0) AS 'Q1',  
 ROUND(@TOTAL6,0) AS 'Q2',  
 ROUND(@TOTAL7,0) AS 'Q3',  
 ROUND(@TOTAL8,0) AS 'Q4',  
 ROUND(@TOTAL9,0) AS 'Month1',   
 ROUND(@TOTAL10,0) AS 'Month2',  
 ROUND(@TOTAL11,0) AS 'Month3',  
 ROUND(@TOTAL12,0) AS 'Week1',  
 ROUND(@TOTAL13,0) AS 'Week2',  
 ROUND(@TOTAL14,0) AS 'Week3',  
 ROUND(@TOTAL15,0) AS 'Week4',  
 ROUND(@TOTAL16,0) AS 'Week4',  
 ROUND(@TOTAL17,0) AS 'Week4',  
 ROUND(@TOTAL,0) AS 'TotalYTD'  
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
 DECLARE @DAY_YEAR_CURT_L DATETIME
 SET @DAY_YEAR_CURT_L = DATEADD(ms,-3,DATEADD(yy,1,@DAY_YEAR))
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
 DECLARE @DAY_WEEK    DATETIME--当前周的周一  
 IF DATEPART(weekday,GETDATE()) = 1  
 SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,7,getdate()),0)      
 ELSE  
 SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0)    
 DECLARE @WEEK_1_F DATETIME    
 DECLARE @WEEK_1_L DATETIME    
 DECLARE @WEEK_2_F DATETIME    
 DECLARE @WEEK_2_L DATETIME    
 DECLARE @WEEK_3_F DATETIME    
 DECLARE @WEEK_3_L DATETIME    
 DECLARE @WEEK_4_F DATETIME    
 DECLARE @WEEK_4_L DATETIME    
 DECLARE @WEEK_5_F DATETIME    
 DECLARE @WEEK_5_L DATETIME    
 DECLARE @WEEK_6_F DATETIME    
 DECLARE @WEEK_6_L DATETIME    
 SET @WEEK_1_F = DATEADD(mm, DATEDIFF(m,0,GETDATE()), 0)--第一周第一天  
 SET @WEEK_1_L = DATEADD(ms,-3,DATEADD(dd,9-DATEPART(weekday,@WEEK_1_F),@WEEK_1_F))--第一周最后一天    
 SET @WEEK_2_F = DATEADD(dd,1,DATEADD(dd,8-DATEPART(weekday,@WEEK_1_F),@WEEK_1_F))--第二周第一天   
 SET @WEEK_2_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_2_F))    
 SET @WEEK_3_F = DATEADD(ww, 1, @WEEK_2_F)    
 SET @WEEK_3_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_3_F))    
 SET @WEEK_4_F = DATEADD(ww, 1, @WEEK_3_F)    
 SET @WEEK_4_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_4_F))   
 SET @WEEK_5_F = DATEADD(ww, 1, @WEEK_4_F)  
 SET @WEEK_5_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_5_F))   
 SET @WEEK_6_F = DATEADD(ww, 1, @WEEK_5_F)     
 SET @WEEK_6_L = DATEADD(ms,-3,DATEADD(ww,1,@WEEK_6_F))  
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
 Week5 FLOAT,  
 Week6 FLOAT,  
 TotalYTD FLOAT     
 )    
 --获得各个时间段的值    
 DECLARE @TABLE TABLE(T INT,T1 INT)    
 INSERT INTO @TABLE(T,T1) VALUES(390,412)    
 INSERT INTO @TABLE(T,T1) VALUES(391,420)    
 INSERT INTO @TABLE(T,T1) VALUES(392,417)    
 INSERT INTO @TABLE(T,T1) VALUES(393,415)    
 INSERT INTO @TABLE(T,T1) VALUES(394,423)    
 INSERT INTO @TABLE(T,T1) VALUES(395,414)    
 INSERT INTO @TABLE(T,T1) VALUES(396,418)    
 INSERT INTO @TABLE(T,T1) VALUES(397,421)    
 INSERT INTO @TABLE(T,T1) VALUES(398,422)    
 INSERT INTO @TABLE(T,T1) VALUES(399,419)    
 INSERT INTO @TABLE(T,T1) VALUES(400,416)    
   
 --今年的总数    
 DECLARE @TOTAL FLOAT     
 SELECT @TOTAL = SUM(C.Value)    
 FROM ConsumptionData C    
 WHERE C.DeviceID = 388  
 AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())    
 AND C.Tariffnum = 0   
 AND C.UsageTypeID IN (1,8,9)   
 --循环ID表    
 DECLARE @ID INT   
 DECLARE @ID1 INT   
 DECLARE CURSOR1 CURSOR FOR SELECT T,T1 FROM @TABLE    
 OPEN CURSOR1    
 FETCH NEXT FROM CURSOR1 INTO @ID,@ID1    
 WHILE (@@fetch_status=0)    
 BEGIN    
  --NAME    
  DECLARE @NAME NVARCHAR(510)    
  SELECT @NAME = Name FROM dbo.ListOfDevices WHERE DeviceID = @ID    
  --Previous Year    
  DECLARE @TOTAL1 FLOAT     
  SELECT @TOTAL1 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL1 IS NULL     
   SET @TOTAL1 = 0    
  --Yearly Target    
  DECLARE @TOTAL2 FLOAT         
  SELECT @TOTAL2 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID1
  AND (C.ReadingDate BETWEEN @DAY_YEAR AND @DAY_YEAR_CURT_L)  
  AND C.Tariffnum = 0   
  IF @TOTAL2 IS NULL     
   SET @TOTAL2 = 0         
  --YTD    
  DECLARE @TOTAL3 FLOAT     
  SELECT @TOTAL3 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL3 IS NULL     
   SET @TOTAL3 = 0    
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
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @QUARTER_1_F AND @QUARTER_1_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL5 IS NULL     
   SET @TOTAL5 = 0    
  --Q2    
  DECLARE @TOTAL6 FLOAT     
  SELECT @TOTAL6 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @QUARTER_2_F AND @QUARTER_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL6 IS NULL     
   SET @TOTAL6 = 0    
  --Q3    
  DECLARE @TOTAL7 FLOAT     
  SELECT @TOTAL7 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @QUARTER_3_F AND @QUARTER_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL7 IS NULL     
   SET @TOTAL7 = 0     
  --Q4    
  DECLARE @TOTAL8 FLOAT     
  SELECT @TOTAL8 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @QUARTER_4_F AND @QUARTER_4_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL8 IS NULL     
   SET @TOTAL8 = 0    
  --Month1    
  DECLARE @TOTAL9 FLOAT     
  SELECT @TOTAL9 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @MONTH_1_F AND @MONTH_1_L)   
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL9 IS NULL     
   SET @TOTAL9 = 0     
  --Month2    
  DECLARE @TOTAL10 FLOAT     
  SELECT @TOTAL10 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @MONTH_2_F AND @MONTH_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL10 IS NULL     
   SET @TOTAL10 = 0    
  --Month3    
  DECLARE @TOTAL11 FLOAT     
  SELECT @TOTAL11 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @MONTH_3_F AND @MONTH_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL11 IS NULL     
   SET @TOTAL11 = 0     
  --Week1    
  DECLARE @TOTAL12 FLOAT     
  SELECT @TOTAL12 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_1_F AND @WEEK_1_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL12 IS NULL     
   SET @TOTAL12 = 0     
  --Week2    
  DECLARE @TOTAL13 FLOAT     
  SELECT @TOTAL13 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_2_F AND @WEEK_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL13 IS NULL     
   SET @TOTAL13 = 0     
  --Week3    
  DECLARE @TOTAL14 FLOAT     
  SELECT @TOTAL14 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_3_F AND @WEEK_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)   
  IF @TOTAL14 IS NULL     
   SET @TOTAL14 = 0     
  --Week4    
  DECLARE @TOTAL15 FLOAT     
  SELECT @TOTAL15 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_4_F AND @WEEK_4_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL15 IS NULL     
   SET @TOTAL15 = 0    
    
  --Week5    
  DECLARE @TOTAL16 FLOAT     
  SELECT @TOTAL16 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_5_F AND @WEEK_5_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL16 IS NULL     
   SET @TOTAL16 = 0     
    
  --Week6    
  DECLARE @TOTAL17 FLOAT     
  SELECT @TOTAL17 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = @ID    
  AND (C.ReadingDate BETWEEN @WEEK_6_F AND @WEEK_6_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @TOTAL17 IS NULL     
   SET @TOTAL17 = 0        
     
  INSERT INTO @TEMP_ENERGY VALUES(  
  @ID,  
  @NAME,    
  ROUND(@TOTAL1,0),    
  ROUND(@TOTAL2,0),    
  ROUND(@TOTAL3,0),    
  ROUND(@TOTAL4,3),    
  ROUND(@TOTAL5,0),    
  ROUND(@TOTAL6,0),    
  ROUND(@TOTAL7,0),    
  ROUND(@TOTAL8,0),    
  ROUND(@TOTAL9,0),    
  ROUND(@TOTAL10,0),   
  ROUND(@TOTAL11,0),    
  ROUND(@TOTAL12,0),    
  ROUND(@TOTAL13,0),    
  ROUND(@TOTAL14,0),    
  ROUND(@TOTAL15,0),  
  ROUND(@TOTAL16,0),  
  ROUND(@TOTAL17,0),    
  0)    
     
 FETCH NEXT FROM CURSOR1 INTO @ID,@ID1    
 END    
 CLOSE CURSOR1    
 DEALLOCATE CURSOR1    
 DELETE @TABLE    
   
 --声明变量    
 --Previous Year    
 DECLARE @SUM_TOTAL_1 FLOAT     
  SELECT @SUM_TOTAL_1 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @DAY_YEAR_F AND @DAY_YEAR_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_1 IS NULL     
   SET @SUM_TOTAL_1 = 0  
 --Yearly Target 
 DECLARE @SUM_TOTAL_2 FLOAT 
 SELECT @SUM_TOTAL_2 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 413    
  AND (C.ReadingDate BETWEEN @DAY_YEAR AND @DAY_YEAR_CURT_L)  
  AND C.Tariffnum = 0   
  IF @SUM_TOTAL_2 IS NULL     
   SET @SUM_TOTAL_2 = 0         
 --YTD    
 DECLARE @SUM_TOTAL_3 FLOAT     
 SELECT @SUM_TOTAL_3 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @DAY_YEAR AND GETDATE())  
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_3 IS NULL     
   SET @SUM_TOTAL_3 = 0      
 --Q1    
  DECLARE @SUM_TOTAL_5 FLOAT     
  SELECT @SUM_TOTAL_5 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @QUARTER_1_F AND @QUARTER_1_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_5 IS NULL     
   SET @SUM_TOTAL_5 = 0    
  --Q2    
  DECLARE @SUM_TOTAL_6 FLOAT     
  SELECT @SUM_TOTAL_6 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @QUARTER_2_F AND @QUARTER_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_6 IS NULL     
   SET @SUM_TOTAL_6 = 0    
  --Q3    
  DECLARE @SUM_TOTAL_7 FLOAT     
  SELECT @SUM_TOTAL_7 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @QUARTER_3_F AND @QUARTER_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_7 IS NULL     
   SET @SUM_TOTAL_7 = 0     
  --Q4    
  DECLARE @SUM_TOTAL_8 FLOAT     
  SELECT @SUM_TOTAL_8 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @QUARTER_4_F AND @QUARTER_4_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_8 IS NULL     
   SET @SUM_TOTAL_8 = 0    
  --Month1    
  DECLARE @SUM_TOTAL_9 FLOAT     
  SELECT @SUM_TOTAL_9 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @MONTH_1_F AND @MONTH_1_L)   
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_9 IS NULL     
   SET @SUM_TOTAL_9 = 0     
  --Month2    
  DECLARE @SUM_TOTAL_10 FLOAT     
  SELECT @SUM_TOTAL_10 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @MONTH_2_F AND @MONTH_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_10 IS NULL     
   SET @SUM_TOTAL_10 = 0    
  --Month3    
  DECLARE @SUM_TOTAL_11 FLOAT     
  SELECT @SUM_TOTAL_11 = SUM(C.Value)    
  FROM ConsumptionData C    
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @MONTH_3_F AND @MONTH_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_11 IS NULL     
   SET @SUM_TOTAL_11 = 0     
  --Week1    
  DECLARE @SUM_TOTAL_12 FLOAT     
  SELECT @SUM_TOTAL_12 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_1_F AND @WEEK_1_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_12 IS NULL     
   SET @SUM_TOTAL_12 = 0     
  --Week2    
  DECLARE @SUM_TOTAL_13 FLOAT     
  SELECT @SUM_TOTAL_13 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_2_F AND @WEEK_2_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_13 IS NULL     
   SET @SUM_TOTAL_13 = 0     
  --Week3    
  DECLARE @SUM_TOTAL_14 FLOAT     
  SELECT @SUM_TOTAL_14 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_3_F AND @WEEK_3_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)   
  IF @SUM_TOTAL_14 IS NULL     
   SET @SUM_TOTAL_14 = 0     
  --Week4    
  DECLARE @SUM_TOTAL_15 FLOAT     
  SELECT @SUM_TOTAL_15 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_4_F AND @WEEK_4_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_15 IS NULL     
   SET @SUM_TOTAL_15 = 0    
    
  --Week5    
  DECLARE @SUM_TOTAL_16 FLOAT     
  SELECT @SUM_TOTAL_16 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_5_F AND @WEEK_5_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_16 IS NULL     
   SET @SUM_TOTAL_16 = 0     
    
  --Week6    
  DECLARE @SUM_TOTAL_17 FLOAT     
  SELECT @SUM_TOTAL_17 = SUM(C.Value)    
 FROM ConsumptionData C  
  WHERE C.DeviceID = 388    
  AND (C.ReadingDate BETWEEN @WEEK_6_F AND @WEEK_6_L)    
  AND C.Tariffnum = 0   
  AND C.UsageTypeID IN (1,8,9)  
  IF @SUM_TOTAL_17 IS NULL     
   SET @SUM_TOTAL_17 = 0        

 INSERT INTO @TEMP_ENERGY VALUES(  
 -1,  
 'Total',    
 ROUND(@SUM_TOTAL_1,0),    
 ROUND(@SUM_TOTAL_2,0),    
 ROUND(@SUM_TOTAL_3,0),    
 1,    
 ROUND(@SUM_TOTAL_5,0),    
 ROUND(@SUM_TOTAL_6,0),    
 ROUND(@SUM_TOTAL_7,0),    
 ROUND(@SUM_TOTAL_8,0),    
 ROUND(@SUM_TOTAL_9,0),    
 ROUND(@SUM_TOTAL_10,0),    
 ROUND(@SUM_TOTAL_11,0),    
 ROUND(@SUM_TOTAL_12,0),    
 ROUND(@SUM_TOTAL_13,0),    
 ROUND(@SUM_TOTAL_14,0),    
 ROUND(@SUM_TOTAL_15,0),   
 ROUND(@SUM_TOTAL_16,0),  
 ROUND(@SUM_TOTAL_17,0),   
 0)    
 SELECT * FROM @TEMP_ENERGY    
END  
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
--Dept. Equipment Energy Efficiency模块    
ALTER PROCEDURE [dbo].[GetEquipmentEnergyEfficiency]    
 @DeviceID INT,     
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
 @Week4 FLOAT,  
 @Week5 FLOAT,  
 @Week6 FLOAT    
AS    
BEGIN    
 DECLARE @Benchmark INT
 SET @Benchmark = 108
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
 --获得当前月的各个星期  
 DECLARE @WEEK_1_F DATETIME    
 DECLARE @WEEK_2_F DATETIME    
 DECLARE @WEEK_3_F DATETIME      
 DECLARE @WEEK_4_F DATETIME      
 DECLARE @WEEK_5_F DATETIME    
 DECLARE @WEEK_6_F DATETIME    
 DECLARE @DAY_WEEK    DATETIME--当前时间周的周一  
 IF DATEPART(weekday,GETDATE()) = 1  
 SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,7,getdate()),0)      
ELSE  
 SET @DAY_WEEK = DATEADD(wk,DATEDIFF(wk,0,GETDATE()),0)  
 SET @WEEK_1_F = DATEADD(mm, DATEDIFF(m,0,GETDATE()), 0)--第一周第一天    
 SET @WEEK_2_F = DATEADD(dd,1,DATEADD(dd,8-DATEPART(weekday,@WEEK_1_F),@WEEK_1_F))--第二周第一天     
 SET @WEEK_3_F = DATEADD(ww, 1, @WEEK_2_F)     
 SET @WEEK_4_F = DATEADD(ww, 1, @WEEK_3_F)     
 SET @WEEK_5_F = DATEADD(ww, 1, @WEEK_4_F)  
 SET @WEEK_6_F = DATEADD(ww, 1, @WEEK_5_F)     
   
 DECLARE @DAY_MOUTH DATETIME  
 SET @DAY_MOUTH = DATEADD(mm,1,CONVERT(VARCHAR(100), DATEADD(dd,-DAY(GETDATE())+1,GETDATE()),23))--下一个月第一天  
   
 DECLARE @DAY_WEEK_NUM_1 INT    
 SET @DAY_WEEK_NUM_1 = DATEDIFF(dd,@WEEK_1_F,@WEEK_2_F)  
   
 DECLARE @DAY_WEEK_NUM_2 INT   
 SET @DAY_WEEK_NUM_2 = DATEDIFF(dd,@WEEK_2_F,@WEEK_3_F)  
   
 DECLARE @DAY_WEEK_NUM_3 INT   
 SET @DAY_WEEK_NUM_3 = DATEDIFF(dd,@WEEK_3_F,@WEEK_4_F)  
   
 DECLARE @DAY_WEEK_NUM_4 INT   
 IF DATEDIFF(dd,@WEEK_4_F,@DAY_MOUTH) >= 7  
   SET @DAY_WEEK_NUM_4 = 7  
 ELSE  
   SET @DAY_WEEK_NUM_4 = DATEDIFF(dd,@WEEK_4_F,@DAY_MOUTH)  
   
 DECLARE @DAY_WEEK_NUM_5 INT   
 IF DATEDIFF(dd,@WEEK_5_F,@DAY_MOUTH) >= 7  
   SET @DAY_WEEK_NUM_5 = 7  
 ELSE  
   SET @DAY_WEEK_NUM_5 = DATEDIFF(dd,@WEEK_5_F,@DAY_MOUTH)  
   
 DECLARE @DAY_WEEK_NUM_6 INT   
 IF DATEDIFF(dd,@WEEK_6_F,@DAY_MOUTH) >= 7  
   SET @DAY_WEEK_NUM_6 = 7  
 ELSE  
 BEGIN  
  SET @DAY_WEEK_NUM_6 = DATEDIFF(dd,@WEEK_6_F,@DAY_MOUTH)  
  IF @DAY_WEEK_NUM_6 < 0  
   SET @DAY_WEEK_NUM_6 = 0  
 END  
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
  Week4 FLOAT,  
  Week5 FLOAT,  
  Week6 FLOAT    
 )    
 DECLARE @VALUE1 FLOAT  
 DECLARE @VALUE2 FLOAT  
 DECLARE @VALUE3 FLOAT  
 DECLARE @VALUE4 FLOAT  
 DECLARE @VALUE5 FLOAT  
 DECLARE @VALUE6 FLOAT  
 DECLARE @VALUE7 FLOAT  
 DECLARE @VALUE8 FLOAT  
 DECLARE @VALUE9 FLOAT  
 DECLARE @VALUE10 FLOAT  
 DECLARE @VALUE11 FLOAT  
 DECLARE @VALUE12 FLOAT  
 DECLARE @VALUE13 FLOAT  
 DECLARE @VALUE14 FLOAT  
 DECLARE @VALUE15 FLOAT  
 DECLARE @VALUE16 FLOAT  
   
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
  0.91,  
  0.91,  
  0.91)    
 --Consumption – Goal    
 SET @VALUE1 = @Benchmark*0.91*220*@DAY_YEAR_NUM  
 IF @VALUE1 > 1000  
 SET @VALUE1 = ROUND(@VALUE1,0)  
 ELSE  
 SET @VALUE1 =  ROUND(@VALUE1,1)  
    
SET @VALUE2 = @Benchmark*0.91*220*@DAY_YTD_NUM  
 IF @VALUE2 > 1000  
 SET @VALUE2 = ROUND(@VALUE2,0)  
 ELSE  
 SET @VALUE2 =  ROUND(@VALUE2,1)  
   
SET @VALUE3 = @Benchmark*0.91*220*@DAY_Q1_NUM  
 IF @VALUE3 > 1000  
 SET @VALUE3 = ROUND(@VALUE3,0)  
 ELSE  
 SET @VALUE3 =  ROUND(@VALUE3,1)  
  
SET @VALUE4 = @Benchmark*0.91*220*@DAY_Q2_NUM  
 IF @VALUE4 > 1000  
 SET @VALUE4 = ROUND(@VALUE4,0)  
 ELSE  
 SET @VALUE4 =  ROUND(@VALUE4,1)  
  
SET @VALUE5 = @Benchmark*0.91*220*@DAY_Q3_NUM  
 IF @VALUE5 > 1000  
 SET @VALUE5 = ROUND(@VALUE5,0)  
 ELSE  
 SET @VALUE5 =  ROUND(@VALUE5,1)  
  
SET @VALUE6 = @Benchmark*0.91*220*@DAY_Q4_NUM  
 IF @VALUE6 > 1000  
 SET @VALUE6 = ROUND(@VALUE6,0)  
 ELSE  
 SET @VALUE6 =  ROUND(@VALUE6,1)  
  
SET @VALUE7 = @Benchmark*0.91*220*@DAY_MONTH_1_NUM  
 IF @VALUE7 > 1000  
 SET @VALUE7 = ROUND(@VALUE7,0)  
 ELSE  
 SET @VALUE7 =  ROUND(@VALUE7,1)  
   
SET @VALUE8 = @Benchmark*0.91*220*@DAY_MONTH_2_NUM  
 IF @VALUE8 > 1000  
 SET @VALUE8 = ROUND(@VALUE8,0)  
 ELSE  
 SET @VALUE8 =  ROUND(@VALUE8,1)  
   
SET @VALUE9 = @Benchmark*0.91*220*@DAY_MONTH_3_NUM  
 IF @VALUE9 > 1000  
 SET @VALUE9 = ROUND(@VALUE9,0)  
 ELSE  
 SET @VALUE9 =  ROUND(@VALUE9,1)  
  
SET @VALUE10 = @Benchmark*0.91*220*@DAY_WEEK_NUM_1  
 IF @VALUE10 > 1000  
 SET @VALUE10 = ROUND(@VALUE10,0)  
 ELSE  
 SET @VALUE10 =  ROUND(@VALUE10,1)  
  
SET @VALUE11 = @Benchmark*0.91*220*@DAY_WEEK_NUM_2  
 IF @VALUE11 > 1000  
 SET @VALUE11 = ROUND(@VALUE11,0)  
 ELSE  
 SET @VALUE11 =  ROUND(@VALUE11,1)  
  
SET @VALUE12 = @Benchmark*0.91*220*@DAY_WEEK_NUM_3  
 IF @VALUE12 > 1000  
 SET @VALUE12 = ROUND(@VALUE12,0)  
 ELSE  
 SET @VALUE12 =  ROUND(@VALUE12,1)  
   
SET @VALUE13 = @Benchmark*0.91*220*@DAY_WEEK_NUM_4  
 IF @VALUE13 > 1000  
 SET @VALUE13 = ROUND(@VALUE13,0)  
 ELSE  
 SET @VALUE13 =  ROUND(@VALUE13,1)  
   
SET @VALUE14 = @Benchmark*0.91*220*@DAY_WEEK_NUM_5  
 IF @VALUE14 > 1000  
 SET @VALUE14 = ROUND(@VALUE14,0)  
 ELSE  
 SET @VALUE14 =  ROUND(@VALUE14,1)  
   
SET @VALUE15 = @Benchmark*0.91*220*@DAY_WEEK_NUM_6  
 IF @VALUE15 > 1000  
 SET @VALUE15 = ROUND(@VALUE15,0)  
 ELSE  
 SET @VALUE15 =  ROUND(@VALUE15,1)  
   
 INSERT INTO @TEMP_ENERGY VALUES('Consumption – Goal',    
  @VALUE1,    
  @VALUE2,    
  @VALUE3,    
  @VALUE4,    
  @VALUE5,    
  @VALUE6,    
  @VALUE7,    
  @VALUE8,    
  @VALUE9,    
  @VALUE10,    
  @VALUE11,    
  @VALUE12,    
  @VALUE13,  
  @VALUE14,  
  @VALUE15)    
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
  @Week4,  
  @Week5,  
  @Week6)    
 --Efficiency    
 SET @VALUE1 = ROUND(@PreviousYear/(@Benchmark*0.91*220*@DAY_YEAR_NUM),2)  
 SET @VALUE2 = ROUND(@YTD/(@Benchmark*0.91*220*@DAY_YTD_NUM),2)  
 SET @VALUE3 = ROUND(@Q1/(@Benchmark*0.91*220*@DAY_Q1_NUM),2)  
 SET @VALUE4 = ROUND(@Q2/(@Benchmark*0.91*220*@DAY_Q2_NUM),2)  
 SET @VALUE5 = ROUND(@Q3/(@Benchmark*0.91*220*@DAY_Q3_NUM),2)  
 SET @VALUE6 = ROUND(@Q4/(@Benchmark*0.91*220*@DAY_Q4_NUM),2)  
 SET @VALUE7 = ROUND(@Month1/(@Benchmark*0.91*220*@DAY_MONTH_1_NUM),2)  
 SET @VALUE8 = ROUND(@Month2/(@Benchmark*0.91*220*@DAY_MONTH_2_NUM),2)  
 SET @VALUE9 = ROUND(@Month3/(@Benchmark*0.91*220*@DAY_MONTH_3_NUM),2)  
 SET @VALUE10 = ROUND(@Week1/(@Benchmark*0.91*220*@DAY_WEEK_NUM_1),2)  
 SET @VALUE11 = ROUND(@Week2/(@Benchmark*0.91*220*@DAY_WEEK_NUM_2),2)  
 SET @VALUE12 = ROUND(@Week3/(@Benchmark*0.91*220*@DAY_WEEK_NUM_3),2)  
 IF @DAY_WEEK_NUM_4 = 0  
 SET @VALUE13 = 0  
 ELSE  
 SET @VALUE13 = ROUND(@Week4/(@Benchmark*0.91*220*@DAY_WEEK_NUM_4),2)  
 IF @DAY_WEEK_NUM_5 = 0  
 SET @VALUE14 = 0  
 ELSE  
 SET @VALUE14 = ROUND(@Week5/(@Benchmark*0.91*220*@DAY_WEEK_NUM_5),2)  
 IF @DAY_WEEK_NUM_6 = 0   
 SET @VALUE15 = 0  
 ELSE  
 SET @VALUE15 = ROUND(@Week6/(@Benchmark*0.91*220*@DAY_WEEK_NUM_6),2)  
 INSERT INTO @TEMP_ENERGY VALUES('Efficiency',  
 @VALUE1,  
 @VALUE2,  
 @VALUE3,  
 @VALUE4,  
 @VALUE5,  
 @VALUE6,  
 @VALUE7,  
 @VALUE8,  
 @VALUE9,  
 @VALUE10,  
 @VALUE11,  
 @VALUE12,  
 @VALUE13,  
 @VALUE14,  
 @VALUE15)  
      
 SELECT * FROM @TEMP_ENERGY    
END  
GO 
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
		WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @MONTH_F AND @MONTH_L
		AND C.Tariffnum = 0 
		AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		--去除小数
		SET @TOTAL = ROUND(@TOTAL,0)
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
  WHERE C.DeviceID=@DeviceID AND C.ReadingDate BETWEEN @DAY_F AND @DAY_L  
  AND C.Tariffnum = 0 
  AND C.UsageTypeID IN (1,8,9)
  IF @TOTAL IS NULL  
   SET @TOTAL = 0.0  
  --去除小数
  SET @TOTAL = ROUND(@TOTAL,0)
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
		WHERE C.DeviceID=@DeviceID AND (C.ReadingDate BETWEEN @HOUR_F AND @HOUR_L)
		AND C.Tariffnum = 0 
		AND C.UsageTypeID IN (1,8,9)
		IF @TOTAL IS NULL
			SET @TOTAL = 0.0
		--去除小数
		SET @TOTAL = ROUND(@TOTAL,0)
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
 DECLARE @YESTODAY_F DATETIME      
 DECLARE @YESTODAY_L DATETIME      
 SET @YESTODAY_F = DATEADD(dd,-1,CONVERT(VARCHAR(100),GETDATE(),23))       
 SET @YESTODAY_L = DATEADD(ms,-3,CONVERT(VARCHAR(100),GETDATE(),23))          
 DECLARE @Chiller1_1 FLOAT      
 DECLARE @Chiller2_1 FLOAT      
 DECLARE @Chiller3_1 FLOAT      
 DECLARE @Chiller4_1 FLOAT 
 DECLARE @Chiller5_1 FLOAT
 SET @Chiller5_1 = 0           
 --Actual Electricity Consumption      
 SELECT @Chiller1_1 = SUM(C.Value)/24      
 FROM ConsumptionData C        
 WHERE C.DeviceID=127   AND C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L 
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9)    
 IF @Chiller1_1 IS NULL      
  SET @Chiller1_1 = 0 
 IF @Chiller1_1 > 1000
	SET  @Chiller1_1 = ROUND(@Chiller1_1,0)
  ELSE
	SET @Chiller1_1 = ROUND(@Chiller1_1,1)
     
 SELECT @Chiller2_1 = SUM(C.Value)/24           
 FROM ConsumptionData C        
 WHERE C.DeviceID=125   AND C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9) 
 IF @Chiller2_1 IS NULL      
  SET @Chiller2_1 = 0      
 IF @Chiller2_1 > 1000
	SET  @Chiller2_1 = ROUND(@Chiller2_1,0)
  ELSE
	SET @Chiller2_1 = ROUND(@Chiller2_1,1)
  
 SELECT @Chiller3_1 = SUM(C.Value)/24         
 FROM ConsumptionData C        
 WHERE C.DeviceID=128   AND C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9)       
 IF @Chiller3_1 IS NULL      
  SET @Chiller3_1 = 0   
 IF @Chiller3_1 > 1000
	SET  @Chiller3_1 = ROUND(@Chiller3_1,0)
  ELSE
	SET @Chiller3_1 = ROUND(@Chiller3_1,1) 
     
 SELECT @Chiller4_1 = SUM(C.Value)/24          
 FROM ConsumptionData C        
 WHERE C.DeviceID=167   AND C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L    
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9) 
 IF @Chiller4_1 IS NULL      
  SET @Chiller4_1 = 0  
 IF @Chiller4_1 > 1000
	SET  @Chiller4_1 = ROUND(@Chiller4_1,0)
  ELSE
	SET @Chiller4_1 = ROUND(@Chiller4_1,1)
     
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual Electricity Consumption',      
  @Chiller1_1,      
  @Chiller2_1,      
  @Chiller3_1,      
  @Chiller4_1,      
  @Chiller5_1      
 )      
 --Actual Accumulation Cooling       
 DECLARE @Chiller1_2 FLOAT      
 DECLARE @Chiller2_2 FLOAT      
 DECLARE @Chiller3_2 FLOAT      
 DECLARE @Chiller4_2 FLOAT   
 DECLARE @Chiller5_2 FLOAT  
 SET @Chiller5_2 = 0       
 SELECT @Chiller1_2 = ((SUM(C.Value)/24)*284.43)    
 FROM ConsumptionData C        
 WHERE C.DeviceID=401 AND (C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L)  
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9)   
 IF @Chiller1_2 IS NULL      
  SET @Chiller1_2 = 0      
 IF @Chiller1_2 > 1000
	SET  @Chiller1_2 = ROUND(@Chiller1_2,0)
  ELSE
	SET @Chiller1_2 = ROUND(@Chiller1_2,1)
 
 SELECT @Chiller2_2 = ((SUM(C.Value)/24)*284.43)      
 FROM ConsumptionData C        
 WHERE C.DeviceID=403   AND (C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L) 
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9)   
 IF @Chiller2_2 IS NULL      
  SET @Chiller2_2 = 0    
 IF @Chiller2_2 > 1000
	SET  @Chiller2_2 = ROUND(@Chiller2_2,0)
  ELSE
	SET @Chiller2_2 = ROUND(@Chiller2_2,1)

 SELECT @Chiller3_2 = ((SUM(C.Value)/24)*284.43)      
 FROM ConsumptionData C        
 WHERE C.DeviceID=404   AND (C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L)
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9)     
 IF @Chiller3_2 IS NULL      
  SET @Chiller3_2 = 0    
 IF @Chiller3_2 > 1000
	SET  @Chiller3_2 = ROUND(@Chiller3_2,0)
  ELSE
	SET @Chiller3_2 = ROUND(@Chiller3_2,1)
	  
 SELECT @Chiller4_2 = ((SUM(C.Value)/24)*284.43)/4   
 FROM ConsumptionData C        
 WHERE C.DeviceID=402   AND (C.ReadingDate BETWEEN @YESTODAY_F AND @YESTODAY_L)  
 AND C.Tariffnum = 0 
 AND C.UsageTypeID IN (1,8,9) 
 IF @Chiller4_2 IS NULL      
  SET @Chiller4_2 = 0  
 IF @Chiller4_2 > 1000
	SET  @Chiller4_2 = ROUND(@Chiller4_2,0)
  ELSE
	SET @Chiller4_2 = ROUND(@Chiller4_2,1)
	    
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual Accumulation Cooling',      
  @Chiller1_2,      
  @Chiller2_2,      
  @Chiller3_2,      
  @Chiller4_2,      
  @Chiller5_2      
 )      
 --Actual COP      
 DECLARE @COP_1 FLOAT    
 DECLARE @COP_2 FLOAT    
 DECLARE @COP_3 FLOAT    
 DECLARE @COP_4 FLOAT 
 DECLARE @COP_5 FLOAT
 IF @Chiller1_1 = 0    
 SET @COP_1 = 0    
 ELSE    
 SET @COP_1 = @Chiller1_2/@Chiller1_1   
 IF @Chiller2_1 = 0    
 SET @COP_2 = 0    
 ELSE    
 SET @COP_2 = @Chiller2_2/@Chiller2_1
 IF @Chiller3_1 = 0    
 SET @COP_3 = 0    
 ELSE    
 SET @COP_3 = @Chiller3_2/@Chiller3_1    
 IF @Chiller4_1 = 0    
 SET @COP_4 = 0    
 ELSE    
 SET @COP_4 = @Chiller4_2/@Chiller4_1  
 IF @Chiller5_1 = 0    
 SET @COP_5 = 0    
 ELSE    
 SET @COP_5 = @Chiller5_2/@Chiller5_1  
     
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual COP',      
  ROUND(@COP_1,2),      
  ROUND(@COP_2,2),      
  ROUND(@COP_3,2),      
  ROUND(@COP_4,2),      
  ROUND(@COP_5,2)      
 )      
 --Actual VS Nominal COP   
 INSERT INTO @TEMP_ENERGY VALUES(      
  'Actual VS Nominal COP',      
  ROUND(0,2),--Nominal Cop Chiller 1# == 0    
  ROUND(@COP_2/5.34,2),      
  ROUND(@COP_3/5.34,2),      
  ROUND(@COP_4/5.78,2),     
  ROUND(@COP_5/5.82 ,2)      
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