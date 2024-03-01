# Formula 1 Mod for Powerpipe

Formula 1 race data analysis using SQLite and Powerpipe.

![image](https://github.com/turbot/powerpipe-mod-formula1/assets/72413708/64420d27-345c-4d06-a401-af805067629d)

## Overview

Dashboards can help answer questions like:

- How many Formula 1 races have been held?
- What is the total number of drivers?
- How many constructors are there in Formula 1?
- How many seasons of Formula 1 racing have occurred?
- What is the distribution of team standings by conference?

## Documentation

- **[Dashboards →](https://hub.powerpipe.io/mods/turbot/formula1/dashboards)**

## Getting Started

### Installation

Download and install Powerpipe (https://powerpipe.io/downloads). Or use Brew:

```sh
brew install turbot/tap/powerpipe
```

## Clone the Mod Repository

```sh
git clone https://github.com/turbot/powerpipe-mod-formula1.git
cd powerpipe-mod-formula1
```

Download the [Formula 1 Race Data](https://www.kaggle.com/datasets/davidcochran/formula-1-race-data-sqlite) (requires signup with [Kaggle](https://www.kaggle.com/))

Extract the downloaded file in the current directory:

```sh
unzip ~/Downloads/archive.zip
```

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database sqlite:Formula1.sqlite
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Powerpipe](https://powerpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://powerpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [Formula1 Mod](https://github.com/turbot/powerpipe-mod-formula1/labels/help%20wanted)