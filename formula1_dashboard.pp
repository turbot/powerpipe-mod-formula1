dashboard "formula1_dashboard" {

  title         = "Formula 1 Dashboard"
  documentation = file("./docs/formula1_dashboard.md")

  container {
    title = "Overview"

    card {
      query = query.formula1_races_count
      width = 3
      type  = "info"
    }

    card {
      query = query.formula1_drivers_count
      width = 3
      type  = "info"
    }

    card {
      query = query.formula1_costructors_count
      width = 3
      type  = "info"
    }

    card {
      query = query.formula1_seasons_count
      width = 3
      type  = "info"
    }
  }

  container {
    title = "Team Performance Analysis"

    chart {
      title = "Team Standings by Conference"
      query = query.formula1_team_standings_by_conference
      type  = "pie"
      width = 6
    }

    chart {
      title = "Points Per Race by Team"
      query = query.formula1_points_per_race_by_team
      type  = "pie"
      width = 6
    }
  }

  container {
    title = "Driver Statistics and Achievements"

    chart {
      title = "Top Scorers of the Season"
      query = query.formula1_top_scorers_of_season
      type  = "column"
      width = 6
      axes {
        x {
          title {
            value = "Driver"
          }
        }
        y {
          title {
            value = "Average Points per Race"
          }
        }
      }
    }

    chart {
      title = "Driver Efficiency Rating (PER)"
      query = query.formula1_driver_efficiency_rating
      type  = "bar"
      width = 6
      axes {
        x {
          title {
            value = "Efficiency Rating"
          }
        }
        y {
          title {
            value = "Driver"
          }
        }
      }
    }
  }

  container {
    title = "Race Highlights and Trends"

    chart {
      title = "Race Scores Over Time"
      query = query.formula1_race_scores_over_time
      type  = "line"
      width = 6
      axes {
        x {
          title {
            value = "Race Dates"
          }
        }
        y {
          title {
            value = "Scores"
          }
        }
      }
    }

    chart {
      title = "Average Attendance per Race"
      query = query.formula1_average_attendance_per_game
      type  = "line"
      width = 6
      axes {
        x {
          title {
            value = "Race Dates"
          }
        }
        y {
          title {
            value = "Average Attendance"
          }
        }
      }
    }
  }

  container {
    title = "Additional Insights"

    chart {
      title = "Distribution of Drivers by Nationality"
      query = query.formula1_driver_nationality_distribution
      type  = "donut"
      width = 6
    }

    chart {
      title = "Distribution of Circuits by Location"
      query = query.formula1_circuit_location_distribution
      type  = "donut"
      width = 6
    }
  }
}

# Card Queries

query "formula1_races_count" {
  sql = <<-EOQ
    select
      count(*) as "Total Races"
    from
      races;
  EOQ
}

query "formula1_drivers_count" {
  sql = <<-EOQ
    select
      count(distinct driverId) as "Total Drivers"
    from
      drivers;
  EOQ
}

query "formula1_costructors_count" {
  sql = <<-EOQ
    select
      count(distinct constructorId) as "Total Constructors"
    from
      constructors;
  EOQ
}

query "formula1_seasons_count" {
  sql = <<-EOQ
    select
      count(*) as "Total Seasons"
    from
      seasons;
  EOQ
}

# Chart Queries

query "formula1_team_standings_by_conference" {
  sql = <<-EOQ
    select
      constructors.name as "team",
      count(case when position = 1 then 1 end) as "wins",
      count(case when position > 1 then 1 end) as "losses"
    from
      constructor_standings
    join constructors on constructor_standings.constructorId = constructors.constructorId
    group by
      constructor_standings.constructorId
    order by
      "wins" desc;
  EOQ
}

query "formula1_points_per_race_by_team" {
  sql = <<-EOQ
    select constructors.name as "team",
      avg(constructor_standings.points) as "average_points"
    from 
      constructor_standings
    join constructors on constructor_standings.constructorId = constructors.constructorId
    group by
      constructor_standings.constructorId
    order by
      "average_points" desc;
  EOQ
}

query "formula1_top_scorers_of_season" {
  sql = <<-EOQ
    select concat(forename, ' ', surname) as "player",
      avg(points) as "average_points_per_game"
    from
      driver_standings
    join drivers on driver_standings.driverId = drivers.driverId
    group by
      driver_standings.driverId
    order by
      "average_points_per_game" desc
    limit 5;
  EOQ
}

query "formula1_driver_efficiency_rating" {
  sql = <<-EOQ
    select concat(forename, ' ', surname) as "player",
      avg(driver_standings.points) / avg(laptimes.milliseconds) as "efficiency_rating"
    from
      driver_standings
    join drivers on driver_standings.driverId = drivers.driverId
    join laptimes on driver_standings.raceId = laptimes.raceId and driver_standings.driverId = laptimes.driverId
    group by
      driver_standings.driverId
    order by
      "efficiency_rating" desc
    limit 5;
  EOQ
}

query "formula1_race_scores_over_time" {
  sql = <<-EOQ
    select date as "date",
      avg(points) as "average_scores"
    from
      races
    join results on races.raceId = results.raceId
    group by
      date;
  EOQ
}

query "formula1_average_attendance_per_game" {
  sql = <<-EOQ
    select date as "game",
      avg(total_results) as "average_attendance"
    from (
      select
        r.date, count(*) as total_results
      from 
        races r
      join results rs on r.raceId = rs.raceId
      group by
        r.date
    ) as attendance_counts
    group by
      date;
  EOQ
}

query "formula1_driver_nationality_distribution" {
  sql = <<-EOQ
    select nationality as "nationality",
      count(*) as "driver_count"
    from
      drivers
    group by
      nationality
    order by
      "driver_count" desc;
  EOQ
}

query "formula1_circuit_location_distribution" {
  sql = <<-EOQ
    select location as "location",
      count(*) as "circuit_count"
    from
      circuits
    group by
      location
    order by
      "circuit_count" desc;
  EOQ
}
