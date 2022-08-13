# temper-influx-exporter

A tiny tool to export temperature data from USB TEMPer

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
    image: ghcr.io/slashnephy/temper-influx-exporter:master
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
```

## Acknowledgements

temper-influx-exporter is based on [sergiokhayyat/temper](https://github.com/sergiokhayyat/temper). Thanks for temper implementation.
