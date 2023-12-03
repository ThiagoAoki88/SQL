1. Quantos jogos olímpicos foram realizados?

select count(distinct games) as Total_Edições_Jogos_Olimpicos
from olympics_history;

2. Lista de todos os jogos das Olimpíadas realizados até agora(2016)

select distinct oh.year,oh.season,oh.city
from olympics_history oh
order by year;

3. O número total de nações que participaram de cada jogo olímpico

with all_countries as
  (select games, nr.region
   from olympics_history oh
   join olympics_history_noc_regions nr ON nr.noc = oh.noc
 -- em trechos como nr.region, você está referenciando a coluna region da tabela olympics_history_noc_regions usando o alias nr
   group by games, nr.region)
select games, count(1) as Total_de_Países
from all_countries
group by games
order by games;

4. Em que ano houve o maior e o menor número de países participantes nas Olimpíadas

 with all_countries as
    (select games, nr.region
     from olympics_history oh
     join olympics_history_noc_regions nr ON nr.noc=oh.noc
     group by games, nr.region),
tot_countries as
    (select games, count(1) as total_countries
     from all_countries
     group by games)
select distinct
    concat(first_value(games) over(order by total_countries)
    , ' - '
    , first_value(total_countries) over(order by total_countries)) as Menos_Países,
    concat(first_value(games) over(order by total_countries desc)
    , ' - '
    , first_value(total_countries) over(order by total_countries desc)) as Mais_Países
    from tot_countries
    order by 1;

5. Qual nação participou de todos os jogos olímpicos?
      with tot_games as
              (select count(distinct games) as total_games
              from olympics_history),
          countries as
              (select games, nr.region as country
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as Total_de_Participações
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.Total_de_Participações
      order by 1;

6. Identificando os esporte praticado em todas as Olimpíadas de verão.
      with t1 as
          	(select count(distinct games) as total_games
          	from olympics_history where season = 'Summer'),
          t2 as
          	(select distinct games, sport
          	from olympics_history where season = 'Summer'),
          t3 as
          	(select sport, count(1) as no_of_games
          	from t2
          	group by sport)
      select *
      from t3
      join t1 on t1.total_games = t3.no_of_games;

7. Quais esportes foram disputados apenas uma vez nas Olimpíadas?
      with t1 as
          	(select distinct games, sport
          	from olympics_history),
          t2 as
          	(select sport, count(1) as no_of_games
          	from t1
          	group by sport)
      select t2.*, t1.games
      from t2
      join t1 on t1.sport = t2.sport
      where t2.no_of_games = 1
      order by t1.sport;

8. O número total de esportes praticados em cada jogo olímpico.
      with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;








