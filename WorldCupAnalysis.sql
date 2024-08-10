USE fifa_wc;
SELECT * FROM worldcups;
SELECT DISTINCT (Winner) FROM worldcups;

-- Fixing Germany FR and Germany Records in worldcups table
SELECT * FROM worldcups WHERE Winner LIKE "Germany%";
UPDATE worldcups SET Winner = "Germany" WHERE Winner LIKE "Germany%";
SELECT * FROM worldcups WHERE `Runners-Up` LIKE "Germany%";
UPDATE worldcups SET `Runners-Up` = "Germany" WHERE `Runners-Up` LIKE "Germany%";
SELECT * FROM worldcups WHERE Third LIKE "Germany%";
UPDATE worldcups SET Third = "Germany" WHERE Third LIKE "Germany%";
SELECT * FROM worldcups WHERE Fourth LIKE "Germany%";
UPDATE worldcups SET Fourth = "Germany" WHERE Fourth LIKE "Germany%";

-- Fixing Germany FR and Germany Records in players table
SELECT * FROM players;
SELECT DISTINCT(`Team Initials`) FROM players ORDER BY `Team Initials`;
UPDATE players SET `Team Initials` = 'GER' WHERE `Team Initials` = 'FRG';

-- Fixing Germany FR and Germany Records in matches table
SELECT * FROM matches;
SELECT DISTINCT(`Home Team Name`) FROM matches ORDER BY `Home Team Name`;
UPDATE matches SET `Home Team Name` = "Germany" WHERE `Home Team Name` LIKE "German%";
UPDATE matches SET `Home Team Name` = "Iran" WHERE `Home Team Name` LIKE "%Iran%";

SELECT DISTINCT(`Away Team Name`) FROM matches ORDER BY `Away Team Name`;
UPDATE matches SET `Away Team Name` = "Germany" WHERE `Away Team Name` LIKE "German%";
UPDATE matches SET `Away Team Name` = "Iran" WHERE `Away Team Name` LIKE "%Iran%";

-- Key Performance Indicators
-- Total Goals Scored By Winning Teams
SELECT c.Year, c.Winner, SUM(m.`Home Team Goals` + m.`Away Team Goals`) AS Total_Goals
FROM matches m
JOIN worldcups c ON m.Year = c.Year
WHERE m.`Home Team Name` = c.Winner OR m.`Away Team Name` = c.Winner
GROUP BY c.Year, c.Winner;

-- 	Total Goals Conceded By Winning Teams
SELECT c.Year, c.Winner, SUM(
CASE
	WHEN m.`Home Team Name` = c.Winner THEN m.`Away Team Goals`
	ELSE m.`Home Team Goals`
END
) AS Total_Goals_Conceded
FROM matches m
JOIN worldcups c ON m.Year = c.Year
WHERE m.`Home Team Name` = c.Winner OR m.`Away Team Name` = c.Winner
GROUP BY c.Year, c.Winner;

-- Host Country Performance
SELECT c.Year, c.Country AS Host, c.Winner, c.`Runners-Up`
FROM worldcups c
WHERE c.Country = c.Winner OR c.Country = c.`Runners-Up`;

-- Average Match Attendance
SELECT m.Year, AVG(m.Attendance) AS Average_Attendance
FROM matches m
GROUP BY m.Year;

-- Consistency in Group and Knockout Stages
SELECT c.Year, c.Winner, COUNT(m.MatchID) AS Matches_Won
FROM matches m
JOIN worldcups c ON m.Year = c.Year
WHERE (m.`Home Team Name` = c.Winner AND m.`Home Team Goals` > m.`Away Team Goals`)
OR (m.`Away Team Name` = c.Winner AND m.`Away Team Goals` > m.`Home Team Goals`)
GROUP BY c.Year, c.Winner;

-- No. Of Clean Sheets by Winning Team
SELECT c.Year, c.Winner, COUNT(*) AS Clean_Sheets
FROM matches m
JOIN worldcups c ON m.Year = c.Year
WHERE (m.`Home Team Name` = c.Winner AND m.`Away Team Goals` = 0)
OR (m.`Away Team Name` = c.Winner AND m.`Home Team Goals` = 0)
GROUP BY c.Year, c.Winner;

-- Experienced Players and Coaches
SELECT p.`Coach Name`, COUNT(DISTINCT p.`Player Name`) AS Experienced_Players
FROM players p
JOIN matches m ON p.`Team Initials` = m.`Home Team Initials`
JOIN worldcups c ON m.`Home Team Name` = c.Winner
GROUP BY p.`Coach Name`
ORDER BY Experienced_Players DESC
LIMIT 10;

















