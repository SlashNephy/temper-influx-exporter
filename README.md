# temper-influx-exporter
A tiny tool to export temperature data from USB TEMPer

Demo -> [dashboard.starry.blue](https://dashboard.starry.blue/d/SwC1MrpWz/system?viewPanel=43&orgId=1&refresh=10s)

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/slashnephy/temper-influx-exporter/latest)](https://hub.docker.com/r/slashnephy/temper-influx-exporter)

`docker-compose.yml`

```yaml
version: '3.8'

services:
  influxdb:
    container_name: InfluxDB
    image: influxdb
    restart: always
    volumes:
      - influxdb:/var/lib/influxdb

  temper-influx-exporter:
    container_name: temper-influx-exporter
    image: slashnephy/temper-influx-exporter:latest
    restart: always
    devices:
      - /dev/bus/usb
    environment:
      # メトリックの取得間隔 (秒)
      INTERVAL: 60
      # InfluxDB アドレス
      INFLUX_ADDR: http://influxdb:8086
      # InfluxDB データベース名
      INFLUX_DB: temper

volumes:
  influxdb:
    local: driver
```

## Acknowledgements

temper-influx-exporter is based on [sergiokhayyat/temper](https://github.com/sergiokhayyat/temper). Thanks for temper implementation.
