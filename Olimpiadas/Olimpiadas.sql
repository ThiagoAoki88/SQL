1. Quantos jogos ol�mpicos foram realizados?

select count(distinct games) as Total_Edi��es_Jogos_Olimpicos
from olympics_history;

2. Lista de todos os jogos das Olimp�adas realizados at� agora(2016)

select distinct oh.year,oh.season,oh.city
from olympics_history oh
order by year;

3. O n�mero total de na��es que participaram de cada jogo ol�mpico

with all_countries as
  (select games, nr.region
   from olympics_history oh
   join olympics_history_noc_regions nr ON nr.noc = oh.noc
 -- em trechos como nr.region, voc� est� referenciando a coluna region da tabela olympics_history_noc_regions usando o alias nr
   group by games, nr.region)
select games, count(1) as Total_de_Pa�ses
from all_countries
group by games
order by games;

4. Em que ano houve o maior e o menor n�mero de pa�ses participantes nas Olimp�adas

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
    , first_value(total_countries) over(order by total_countries)) as Menos_Pa�ses,
    concat(first_value(games) over(order by total_countries desc)
    , ' - '
    , first_value(total_countries) over(order by total_countries desc)) as Mais_Pa�ses
    from tot_countries
    order by 1;

5. Qual na��o participou de todos os jogos ol�mpicos?
      with tot_games as
              (select count(distinct games) as total_games
              from olympics_history),
          countries as
              (select games, nr.region as country
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as Total_de_Participa��es
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.Total_de_Participa��es
      order by 1;

6. Identificando os esporte praticado em todas as Olimp�adas de ver�o.
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

7. Quais esportes foram disputados apenas uma vez nas Olimp�adas?
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

8. O n�mero total de esportes praticados em cada jogo ol�mpico.
      with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;








