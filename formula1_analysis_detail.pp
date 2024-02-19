dashboard "formula1_analysis_detail" {

  title = "Formula 1 Race Detail"

  input "race_id" {
    title = "Select a Race:"
    query = query.formula1_race_input
    width = 4
  }

  container {

    card {
      query = query.formula1_race_winner
      width = 3
      args  = [self.input.race_id.value]
    }

    card {
      query = query.formula1_race_average_speed
      width = 3
      args  = [self.input.race_id.value]
    }

    card {
      query = query.formula1_race_attendance
      width = 3
      args  = [self.input.race_id.value]
    }

    card {
      query = query.formula1_race_fastest_lap
      width = 3
      args  = [self.input.race_id.value]
    }

  }

  container {

    container {
      width = 12

      table {
        title = "Race Overview"
        type  = "line"
        width = 6
        query = query.formula1_race_overview
        args  = [self.input.race_id.value]
      }
      chart {
        title = "Team Points Distribution"
        width = 6
        type  = "pie"
        query = query.formula1_race_team_points_distribution
        args  = [self.input.race_id.value]
      }


    }

    container {
      width = 12

      table {
        title = "Top 10 Constructor Standings"
        width = 6
        query = query.formula1_race_constructor_standings
        args  = [self.input.race_id.value]
      }

      table {
        title = "Top 10 Driver Standings"
        width = 6
        query = query.formula1_race_driver_standings
        args  = [self.input.race_id.value]
      }
    }

    container {
      width = 12
      table {
        title = "Top 10 Race Results"
        width = 6
        query = query.formula1_race_results
        args  = [self.input.race_id.value]
      }
    }

  }

}

# Input query

query "formula1_race_input" {
  sql = <<-EOQ
    select
      name as label,
      raceId as value
    from
      races
    order by
      name;
  EOQ
}

# Card queries

query "formula1_race_winner" {
  sql = <<-EOQ
    select
      'Winner' as label,
      drivers.forename || ' ' || drivers.surname as value
    from
      results
      join drivers on results.driverId = drivers.driverId
    where
      results.raceId = $1
      and results.position = 1;
  EOQ
}

query "formula1_race_average_speed" {
  sql = <<-EOQ
    select
      'Average Speed' as label,
      avg(results.fastestLapSpeed) as value
    from
      results
    where
      results.raceId = $1;
  EOQ
}

query "formula1_race_attendance" {
  sql = <<-EOQ
    select
      'Attendance' as label,
      count(*) as value
    from
      results
    where
      results.raceId = $1;
  EOQ
}

query "formula1_race_fastest_lap" {
  sql = <<-EOQ
    select
      'No of Laps' as label,
      results.laps as value
    from
      results
    where
      results.raceId = $1;
  EOQ
}

# Other detail page queries

query "formula1_race_overview" {
  sql = <<-EOQ
    select
      races.name as "Race Name",
      races.date as "Date",
      races.time as "Time",
      circuits.name as "Circuit",
      circuits.location as "Location",
      races.round as "Round",
      circuits.country as "Country"
    from
      races
      join circuits on races.circuitId = circuits.circuitId
    where
      races.raceId = $1;
  EOQ
}

query "formula1_race_results" {
  sql = <<-EOQ
    select
      results.position as "Position",
      drivers.forename || ' ' || drivers.surname as "Driver",
      constructors.name as "Constructor",
      results.points as "Points",
      results.laps as "Laps",
      results.time as "Time",
      results.statusId as "Status"
    from
      results
      join drivers on results.driverId = drivers.driverId
      join constructors on results.constructorId = constructors.constructorId
    where
      results.raceId = $1
    order by
      results.position
    limit 10;
  EOQ
}

query "formula1_race_team_points_distribution" {
  sql = <<-EOQ
    select
      constructors.name as "Constructor",
      sum(results.points) as "Total Points"
    from
      results
      join constructors on results.constructorId = constructors.constructorId
    where
      results.raceId = $1
    group by
      constructors.name
    order by
      "Total Points" desc;
  EOQ
}

query "formula1_race_constructor_standings" {
  sql = <<-EOQ
    select
      constructors.name as "Constructor",
      constructor_standings.points as "Points",
      constructor_standings.position as "Position",
      constructor_standings.wins as "Wins"
    from
      constructor_standings
      join constructors on constructor_standings.constructorId = constructors.constructorId
    where
      constructor_standings.raceId = $1
    order by
      constructor_standings.position
    limit 10;
  EOQ
}

query "formula1_race_driver_standings" {
  sql = <<-EOQ
    select
      drivers.forename || ' ' || drivers.surname as "Driver",
      driver_standings.points as "Points",
      driver_standings.position as "Position",
      driver_standings.wins as "Wins",
      avg(laptimes.milliseconds) as "Average Lap Time",
      min(laptimes.milliseconds) as "Best Lap Time",
      max(laptimes.milliseconds) as "Worst Lap Time"
    from
      driver_standings
      join drivers on driver_standings.driverId = drivers.driverId
      join laptimes on driver_standings.driverId = laptimes.driverId
    where
      driver_standings.raceId = $1
    group by
      drivers.forename || ' ' || drivers.surname,
      driver_standings.points,
      driver_standings.position,
      driver_standings.wins
    order by
      driver_standings.position, "Average Lap Time"
      limit 10;
  EOQ
}
