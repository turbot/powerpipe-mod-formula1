# Formula1 Data Analysis Mod for PowerPipe

Formula 1 race data analysis using SQLite and PowerPipe.

![formula1-analysis-detail-image](https://github.com/turbot/powerpipe-mod-formula1/assets/72413708/4d4512b3-09a6-436a-bffb-8f773c12fc97)

![formula1-analysis-dashboard-image](https://github.com/turbot/powerpipe-mod-formula1/assets/72413708/64420d27-345c-4d06-a401-af805067629d)

## Installation

Download and install Powerpipe (https://powerpipe.io/downloads). Or use Brew:

```sh
brew install turbot/tap/powerpipe
```

## Clone the Mod Repository

```sh
git clone https://github.com/turbot/powerpipe-mod-formula1.git
cd powerpipe-mod-formula1
```

## Get the Dataset

Download the [Formula 1 Race Data](https://www.kaggle.com/datasets/davidcochran/formula-1-race-data-sqlite).

Unzip the file to the cloned mod directory.

```sh
unzip /Users/root/Downloads/archive.zip
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