# CRS MANAGER: Прототип управления хранилищами через http-протокол

**ВНИМАНИЕ:** проект находится на стадии прототипа. Ни в коем случае не используйте на продуктиве!

## Возможности

* Хранение списка хранилищ 1С
* Просмотр списка пользователей в разрезе хранилищ
* Создание, деактивация, восстановлене пользователей хранилищ
* Просмотр истории версий хранилищ

## Как развернуть

### Windows

* Скачиваем сборку под Windows [OneScript.Web 0.8.1](https://github.com/EvilBeaver/OneScript.Web/releases/tag/v0.8.1) (архив oscript.web-win-x64.zip)
* Распаковываем архив `oscript.web-win-x64.zip` в любой удобный каталог
* Клонируем текущий проект
```
git clone https://github.com/otymko/crs-manager.git crs-manager
```
* Переходим в каталог `./crs-manager/src`
* Выполняем команду для установки зависимостей (требуемых onescript библиотек)
```
opm install -l
```
* Из консоли выполняем команду:
```
%PATH_TO_OSWEB%/OneScript.WebHost.exe
```
где %PATH_TO_OSWEB% можеть иметь значение:
```
D:\develop\oscript.web-win-x64
```
полный пример строки запуска:
```
D:\develop\oscript.web-win-x64\OneScript.WebHost.exe
```
* Запущенное приложение будет доступно по адресу http://localhost:5000/

### Docker

* Клонируем текущий проект
```
git clone https://github.com/otymko/crs-manager.git crs-manager
```
* Переходим в каталог `./crs-manager`
#### Вручную

    * Соберем docker образ. Из консоли выполним:
    ```
    docker build -t crs-manager .
    ```
    * Запустим контейнер. Выполним из консоли:
    ```
    docker run --rm -p 5000:5000 -v crs-manager-data:/app/data --name my-crs-manager crs-manager
    ```
    где:
        + crs-manager-data - имя тома для хранения данных
        + my-crs-manager - имя контейнера
        + crs-manager - имя образа, собранного ранее
        + левое 5000 - порт на локальном хосте

#### С помощью docker-compose

    * Выполним из консоли:
    ```
    docker-compose up -d
    ```

* Запущенное приложение будет доступно по адресу http://localhost:5000/

## Как вести разработку

Для разработки используются следующие таргеты:
* OneScript.Web 0.8.1
* OneScript 1.6.0

Используется:
* Русский вариант синтаксиса
* UI и модульное тестирование (пока не опубликовано)
* Разработка по `gitflow`

Прежде чем `кодить` нужно:
* Убедиться, что cуществует issue
* Обсудить идею с владельцами проекта

## Лицензия

Используется лицензия [MIT License](LICENSE)
