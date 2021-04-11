
--Modify it to show the matchid and player name for all goals scored by Germany.

SELECT matchid, player FROM goal 
WHERE teamid = 'GER'

--Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2 FROM game
WHERE id = 1012

--Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT goal.player, goal.teamid, game.stadium, game.mdate FROM game
JOIN goal 
ON game.id = goal.matchid
WHERE goal.teamid = 'GER'

--Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT game.team1, game.team2, goal.player FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE 'Mario%'

--Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT goal.player, goal.teamid, eteam.coach, goal.gtime FROM goal
JOIN eteam
ON goal.teamid= eteam.id
WHERE goal.gtime <= 10

--List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT game.mdate, eteam.teamname FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

--List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT goal.player FROM goal
JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw'

--show the name of all players who scored a goal against Germany.

SELECT DISTINCT goal.player FROM game
JOIN goal 
ON game.id = goal.matchid 
WHERE goal.teamid!= 'GER' AND (game.team1='GER' OR game.team2 = 'GER')

--Show teamname and the total number of goals scored.

SELECT eteam.teamname, COUNT(goal.gtime) FROM eteam
JOIN goal
ON eteam.id = goal.teamid
GROUP BY eteam.teamname

--Show the stadium and the number of goals scored in each stadium.

SELECT game.stadium, COUNT(goal.gtime) FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY game.stadium 

--For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT game.id, game.mdate, COUNT(goal.gtime)FROM game
JOIN goal
ON game.id = goal.matchid 
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY game.id, game.mdate

--For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT goal.matchid, game.mdate, COUNT(goal.gtime)FROM game
JOIN goal
ON game.id = goal.matchid 
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate

--List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercis

SELECT game.mdate, game.team1,
  SUM(CASE WHEN goal.teamid=team1 THEN 1 ELSE 0 END) AS score1,
  game.team2,
  SUM(CASE WHEN goal.teamid=team2 THEN 1 ELSE 0 END) AS score2
FROM game 
LEFT JOIN goal 
ON game.id = goal.matchid
GROUP BY game.mdate, goal.matchid, game.team1, game.team2