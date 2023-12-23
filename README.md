# 날씨 앱

## 팀원
| 프로필 사진 | <a href="https://github.com/bamsak"><img src="https://avatars.githubusercontent.com/u/114239407?v=4" width="90" height="90"></a> | <a href="https://github.com/KSK9820"><img src="https://avatars.githubusercontent.com/u/68066104?v=4" width=90></a> | 
| ---- | ---------- | --------- | 
| in Github | [@bamsak](https://github.com/bamsak) | [@KSK9820](https://github.com/KSK9820) 
| in SeSAC | 밤삭 | 도라

<br/>

## 프로젝트 파일 구조
```
├── AppDelegate.swift
├── Controller
│   └── ViewController.swift
├── Extension
│   ├── Bundle+Extension.swift
│   └── DateFormatter+Extension.swift
├── Model
│   ├── APIDTO
│   │   ├── CommonWeatherDTO.swift
│   │   ├── CurrentWeather.swift
│   │   └── WeeklyWeather.swift
│   ├── CurrentLocationInfo.swift
│   ├── Error
│   │   └── NetworkError.swift
│   ├── HTTP
│   │   └── HTTPMethod.swift
│   └── URL
│       ├── Implementation
│       │   ├── WeatherDataURL.swift
│       │   └── WeatherImageURL.swift
│       └── Interface
│           └── APIBaseURLProtocol.swift
├── SceneDelegate.swift
├── Utility
│   ├── ImageCache
│   │   └── NSCacheMananger.swift
│   ├── Location
│   │   ├── Implemetation
│   │   │   ├── CurrentLocationManager.swift
│   │   │   └── LocationManager.swift
│   │   └── Interface
│   │       ├── CurrentLocationManagable.swift
│   │       └── LocationRequestDelegate.swift
│   ├── Network
│   │   ├── Implementation
│   │   │   └── NetworkManager.swift
│   │   └── Interface
│   │       └── NetworkManagable.swift
│   ├── URLFormat
│   │   ├── Implementation
│   │   │   ├── WeatherImageURLFormatter.swift
│   │   │   └── WeatherURLFormatter.swift
│   │   └── Interface
│   │       └── URLFormattable.swift
│   └── Weather
│       ├── Implementation
│       │   ├── WeatherDataManager.swift
│       │   └── WeatherImageManager.swift
│       └── Interface
│           ├── ImageUpdatable.swift
│           ├── WeatherDataDelegate.swift
│           └── WeatherUpdateDelegate.swift
└── View
    ├── CurrentHeaderView.swift
    ├── MainWeatherView.swift
    ├── Protocol
    │   ├── ReuseIdentifiable.swift
    │   ├── UIUpdatable.swift
    │   └── AlertPresentable.swift
    └── WeeklyWeatherCell.swift
```
<br/>

## 프로젝트 개요
Open Weather Map API를 사용해서 사용자의 현재 위치를 기반으로 현재 날씨, 주간 날씨를 보여주는 앱
추가적으로 좌표(위도, 경도)값을 입력받아 날씨 정보를 업데이트할 수 있다.

---

## 객체의 역할
### Controller


| 이름 | 타입 | 구현 내용 |
| -------- | -------- | -------- |
| UIUpdateable | protocol | MainWeatherView의 업데이트를 추상화한 delegate protocol |
| MainWeatherViewDelegate | protocol | cell과 header의 context를 가공해서 전달하는 delegate protocol |
| AlertPresenttable | protocol | View가 UIAlertController의 present를 추상화한 protocol |
| ViewController | class | MainWeatherView의 Controller |

---

### View
| 이름 | 타입 | 구현 내용 |
| -------- | -------- | -------- |
| ReuseIdentifiable | protocol | ReuseIdentifier가 필요한 View가 따르는 프로토콜 |
| WeeklyWeatherCell | class | 주간 날씨 정보를 collectionView에 보여주는 cell |
| CurrentHeaderView | class | 현재 날씨 정보를 collectionView에 보여주는 headerView |
| MainWeatherView | class | 모든 날씨 정보와 배경화면을 구현하여 사용자에게 보여지는 MainView |

---
### Utility

#### ImageCache
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| NSCacheManager | class | 네트워크 통신을 통하여 받아온 날씨 이미지를 메모리캐싱을 하기 위한 객체 |

#### URLFormat
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| URLFormattable | protocol | String타입의 URL정보를 URL타입으로 변환시켜주는 protocol, 기본 구현으로 URL타입으로 변환하게 하는 기능을 가지고 있음. |
| WeatherURLFormatter | struct | URLFormattable protocol을 채택하며, 날씨 정보를 받아오기 위한 url로 formatting해주는 객체  |
| WeatherImageURLFormatter | struct | URLFormattable protocol을 채택하며, 날씨 이미지를 받아오기 위한 url로 formatting해주는 객체  |

#### Network
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| NetworkManagable | protocol | NetworkManager를 추상화한 protocol |
| NetworkManager | class | URLSession을 이용해 API통신을 해주는 객체 |

#### Location
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| LocationRequestDelegate | protocol | 사용자의 location을 업데이트해주기 위한 delegate protocol |
| CurrentLocationManagable | protocol | 사용자의 현재 위치 정보를 관리해주는 객체를 추상화한 delegate protocol |
| LocationManager | class | CoreLocation을 통해 사용자의 location 정보를 관리해주는 객체 |
| CurrentLocationManager | class | 사용자의 현재 위치에 대한 정보를 관리해주는 객체 |

#### Weather
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| WeatherDataDelegate | protocol | WeatherDataManager를 추상화한 delegate protocol | 
| WeatherImageDelegate | protocol | WeatherImageManager를 추상화한 delegate protocol | 
| WeatherUpdateDelegate | protocol | 날씨 정보의 업데이트를 위해 네트워크 요청을 추상화한 delegate protocol | 
| WeatherDataManager | class | WeatherDataDelegate를 채택해서 View의 CollectionView에 표시할 정보를 전달하는 객체|
| WeatherImageManager | class | WeatherImageDelegate를 채택해서 날씨 이미지를 요청하고, 받아온 정보를 캐시에 저장하고 completion을 보내는 객체|

---
#### Extension
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| Bundle+Extension     | extension | API키를 저장하기 위한 extension |
| DateFormatter+Extension | extension | Int형 date를 지정한 형태의 date로 변환하는 extension |

---
### Model
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| CurrentLocationInfo | struct | CLPlaceMarks로 변환한 정보를 가지고 있는 구조체 |
#### HTTP
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| HTTPMethod | enum | HTTP request의 종류 case 구분 |
#### URL
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| APIBaseURLProtocol | protocol | API의 base가 되는 url을 해당 protocol을 따르는 객체가 가지도록 추상화한 protocol  |
| WeatherDataURL     | enum     | 날씨 정보를 받아오기 위한 API url정보를 가지고 있는 객체 |
| WeatherImageURL    | enum | 날씨 이미지 정보를 받아오기 위한 API url정보를 가지고 있는 객체 |

#### Error
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| NetworkError | enum | 네트워크 통신시 발생할 수 있는 에러 케이스를 분류 |
#### APIDTO
| 이름 | 타입 | 구현 내용|
| -------- | -------- | -------- |
| CurrentWeather | struct | 현재 날씨를 받아오는 API의 response를 JSON 파싱하기 위한 구조체 정의 |
| WeeklyWeather | struct | 5일 예보를 받아오는 API의 response를 JSON을 파싱하기 위한 구조체 정의 |
| CommonWeatherDTO | enum | CurrentWeather와 WeeklyWeather에서 공통으로 사용하는 구조체는 분리해서 정의 |

---

## 구현영상


| 위치 정보 접근 권한 및 날씨 정보 받아오기, refresh | 입력받은 위, 경도로 날씨정보 업데이트  |
|:--------:|:--------:|
|<img src="https://github.com/tasty-code/ios-weather-forecast/assets/68066104/023902bf-19e3-47fb-93b0-22f50430cc56" width="300" height="650">|<img src="https://github.com/tasty-code/ios-weather-forecast/assets/68066104/1fe421ed-445a-45a8-80d5-187cdcaece9f" width="300" height="650">|

---

## Trouble Shooting
<pre>
<a href="https://github.com/tasty-code/ios-weather-forecast/pull/28" target="_top">STEP1</a>
<a href="https://github.com/tasty-code/ios-weather-forecast/pull/37" target="_top">STEP2</a>
<a href="https://github.com/tasty-code/ios-weather-forecast/pull/46" target="_top">STEP3</a>
<a href="https://github.com/tasty-code/ios-weather-forecast/pull/50" target="_top">STEP4</a>
</pre>
