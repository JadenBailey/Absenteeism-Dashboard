-- Create a Join Table

SELECT * FROM absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID
LEFT JOIN Reasons r
ON a.`Reason for absence` = r.Number;

-- ----------------------------------------------- --

-- Find the Healthiest Employees for the Bonus

SELECT * FROM absenteeism_at_work
WHERE `Social drinker` = 0 AND `Social smoker` = 0
AND `Body mass index` < 25 AND 
`Absenteeism time in hours` < (SELECT AVG(`Absenteeism time in hours`) FROM absenteeism_at_work);

-- ----------------------------------------------- --

-- Compensation Rate Increase for Non-Smokers

SELECT COUNT(*) as nonsmokers FROM absenteeism_at_work
WHERE `social smoker` = 0;

-- 5 days a week * 8 working hours = 40 hours a week * 52 weeks in a year = 2,080 total working hours

-- 2,080 working hours * 686 Non-Smokers = 1,426,880 total hours worked by Non-Smokers

-- $983,221 budget / 1,426,880 = $0.68 increase per hour (or $1,414.40 per year)

-- ----------------------------------------------- --

-- Optimize this Query

SELECT
a.ID,
r.reason,
`Month of absence`,
`Day of the week`,
`Body mass index`,
CASE	WHEN `Body mass index` < 18.5 THEN 'Underweight'
		WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN 'Healthy'
        WHEN `Body mass index` BETWEEN 25 AND 30 THEN 'Overweight'
        WHEN `Body mass index` > 30 THEN 'Obese'
        ELSE 'Unknown' END as BMI_Category,
CASE 	WHEN `Month of absence` IN (12,1,2) THEN 'Winter'
		WHEN `Month of absence` IN (3,4,5) THEN 'Spring'
        WHEN `Month of absence` IN (6,7,8) THEN 'Summer'
        WHEN `Month of absence` IN (9,10,11) THEN 'Fall'
        ELSE 'Unknown' END as Season_Names,
`Seasons`,
`Transportation expense`,
`Education`,
`Son`,
`Social drinker`,
`Social smoker`,
`Pet`,
`Disciplinary failure`,
`Age`,
`Work load Average/day`,
`Absenteeism time in hours`
FROM absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID
LEFT JOIN Reasons r
ON a.`Reason for absence` = r.Number;