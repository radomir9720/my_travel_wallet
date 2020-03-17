# My Travel Wallet

Приложение для учета финансов в путешествиях.

## Пет-проект, цель которого - "прощупать почву" в разработке мобильных приложений.

## Дисклеймер:
Не стоит искать в этом приложении изъяны и несостыковки(вы их обязательтно найдете). Некоторые моменты реализованы неправильно из-за неопытности и незнания как правильно, некоторые из-за ограничения во времени, которое было уделено под этот проект.

## Цель и полезность приложения:
Приложение поможет путешественникам следить за финансами. Отличие этого приложения от других "кошельков" - конвертер валют. Вы всегда будете видеть эквивалент в валюте, в которой привыкли считать.

## Разделы приложения:

### Главная страница с путешествиями:

![GitHub Logo](https://downloader.disk.yandex.ru/preview/a213f42ac01e91c92b3986eabaae8d692052407133272c8ba1e9c6be5ebdda40/5e70e90b/DRpIBSzsP51Xp0aILn-4tjl40WubFZ-1hbsWUclWJX6DeVPqy2KkePjdjktcEDAKhV9wsdl8-TWBTxUAPuknRg==?uid=0&filename=home_page.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=172518326&size=2048x2048)

  * Функционал:
  
    * Вход через G+(При входе осуществляется скачивание данных из firebase, при наличие таких(например, если пользователь использовал приложение на другом смартфоне, потом решил его сменить, при логине в новый смартфон данные синхронизируются), осуществляется копирование данных из облака в локальную память приложения(hive) и состояние приложения обновляется).
    * Добавлять путешествия.
      Указывать можно название путешествия, даты начала и окончания(по умолчанию они заполнены: дата начала - сегодняшний день, дата окончания - сегодняшний день + 7 дней). Базовую валюту по умолчанию(валюту, в которой предполагается совершать больше всего покупок во время путешествия. При добавлениеи нового расхода можно будет выбрать валюту отличную от базовой. Цель базовой валюты: она будет проставлена по умолчанию при добавлении нового расхода, чтобы пользователь не выбирал постоянно эту валюту самостоятельно), и, валюту в которую надо конвертировать расходы. Все поля обязательны к заполнению и валидируются. Поле названия путешествия проверяется на длину введенного текста. 
Так же, осуществляется проверка возможности конвертации из одной валюты в другую. Например, сервис, который интегрирован для получения информации по курсу валют, позволяет конверитровать новозеландский доллар только в российские рубли и наоборот. Таким образом, если клиент выберет в качестве базовой валюты новозеландский доллар, то в качестве валюты для конвертации он сможет выбрать только российские рубли. Так же в интерфейсе присутсвует кнопка, позволяющая поменять местами при добавлении нового путешествия баховую валюту, и валюту для конвертации.
    * Удалять путешествия.
    * Добавлять расходы.
     Пользователь вводит название расхода(поле валидируется), сумму(поле валидируется), дату расхода(поле обязательно к заполнению, по умолчанию проставлена сегодняшняя дата), валюту операции. Есть две кнопки: "Отмена" и "Добавить". В режиме реального времени перед тем как добавить этот расход пользователь уже видит сконвертированную сумму.
    * Удалять расходы.

![GitHub Logo](https://downloader.disk.yandex.ru/preview/e094bf7913d210a5f078ea17313c8323f7bf3cca37be61edf6981b7616d2d4b4/5e70ecd2/OrOPFgBoFxs1OfdGTsVbzfPAOmKQcINwNpqe3Hv7CpkUCsSwWgbLIjZFMP-G7amQp9ACyMkTYMuEYjz0dzHKGQ==?uid=0&filename=add_new_travel.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=172518326&size=2048x2048)

### Страница с конвертацией валют:

![GitHub Logo](https://downloader.disk.yandex.ru/preview/ce02c456539ea2f598a9dc3201e2fac4c37d058186b9a2c368a91ba2c80870ae/5e70f36f/EQhs882bSEG1Q0UkDpA-CodSiBA7LeCJEUrOeDvG4ngu_Qhi9m3-RG8JSbZ1i063OBVDcp8Oyw2c_fv_ttk7pg==?uid=0&filename=currency_page.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=172518326&size=2048x2048)

 * Функционал:
 
  * Выбор базовой валюты.
  * Добавление/удаление валют для конвертации(при добавлении осуществляется проверка на возможность конвертации из базовой валюты. Пользователю к выбору будут предоставлены только валюты, в которые можно сконвертировать денежные единицы).
  * Конвертация валюты из базовой в выбранные пользователем.
  * Есть возможность ввода суммы в поле(валидируется). При вводе значений в это поле сумма конвертируется в режиме онлайн.

### Страница с настройками.

![GitHub Logo](https://downloader.disk.yandex.ru/preview/bad4badb29542f8181c9a154ef60ad630ed00c1ca9edf90a9079d48d5607b9dd/5e70f392/0u7x3Oa0l2LQ-R5jaZRVGCE7es_6DRuG-aEvJn7Yd0H_GlWuWzjrYCbQ-Z8p0X0Sld0FksSDdDCLWz--5YuBHA==?uid=0&filename=settings_page.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&tknv=v2&owner_uid=172518326&size=2048x2048)

 * Функционал:
 
  * Смена темы со светлой на темную и наоборот.
   Работает без перезапуска приложения, естественно.
  * Выход из аккаунта G+(при выходе так же делается снимок состояния приложения и сохраняется в firebase).
  * Так же, на этом экране отражена версия приложения.

# Инструменты, используемые в реализации:

* Хранение данных:

 * Hive
 * Shared preferences
 * Google Firebase
 
* Api:
 
 * http://currate.ru/
 
* Авторизация:

 * Google sign in.
