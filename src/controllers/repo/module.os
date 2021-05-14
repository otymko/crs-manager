#Использовать "../../model"
#Использовать crs-api

Перем ЗаголовокСписка;
Перем ЗаголовокЗаписи;

#Область ПрограммыйИнтерфейс

Функция Index() Экспорт
	
	Модель = ОбщегоНазначения.МодельСтраницы(ЗаголовокСписка);
	
	СписокХранилищ = МенеджерБазДанных.СписокХранилищКонфигураций();
	
	СписокДляВывода = Новый Массив();

	Для Каждого ТекХранилище Из СписокХранилищ Цикл
		СписокДляВывода.Добавить(СтрокаСпискаИзЗаписи(ТекХранилище));
	КонецЦикла;

	Модель.Вставить("Список", СписокДляВывода);
	Возврат Представление("page", Модель);
	
КонецФункции

Функция Save() Экспорт
	
	Запись = Неопределено;
	
	Если ЭтотОбъект.ЗапросHTTP.Метод = "POST" Тогда
		
		ИдентификаторЗаписи = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Идентификатор"];
		Если ЗначениеЗаполнено(ИдентификаторЗаписи) Тогда		
			Запись = МенеджерБазДанных.ХранилищеПоИдентификатору(ИдентификаторЗаписи);
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Запись) Тогда
			Запись = Новый ХранилищеКонфигурации();
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Пароль"]) Тогда
			Пароль = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Пароль"];
		Иначе
			Пароль = Запись.Пароль;
		КонецЕсли;
		
		Запись.Идентификатор   = ИдентификаторЗаписи;
		Запись.Имя             = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Имя"];
		Запись.Сервер          = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Сервер"];
		Запись.Путь            = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Путь"];
		Запись.Пользователь    = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Пользователь"];
		Запись.Пароль          = Пароль;
		Запись.Комментарий     = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Комментарий"];
		
		МенеджерБазДанных.МенеджерСущностей.Сохранить(Запись);
		
		Возврат Перенаправление("/repo");
		
	КонецЕсли;
	
	Модель = ОбщегоНазначения.МодельСтраницы(ЗаголовокЗаписи);
	Модель.Вставить("Запись", "Хранилище конфигурации"); // fixme: это заголовок записи
	
	Возврат Index();
	
КонецФункции

Функция Add() Экспорт
	
	Запись = ШаблонЗаписи();

	СписокСерверовХранилищ = ОбщегоНазначения.СписокСерверовХранилищ();
	
	Модель = ОбщегоНазначения.МодельСтраницы(ЗаголовокСписка);
	Модель.Вставить("Серверы", СписокСерверовХранилищ);
	Модель.Вставить("ТекущийСервер", 0);
	Модель.Вставить("Запись", Запись);
	Модель.Вставить("ЗаголовокЗаписи", "Новая запись");

	Возврат Представление("element", Модель);
	
КонецФункции

Функция Edit() Экспорт
	
	Запись = ШаблонЗаписи();
	
	Если ЭтотОбъект.ЗапросHTTP.Метод = "POST" Тогда
		ИдентификаторЗаписи = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Идентификатор"];
		СуществующаяЗапись = МенеджерБазДанных.ХранилищеПоИдентификатору(ИдентификаторЗаписи);
		ЗаполнитьЗначенияСвойств(Запись, СуществующаяЗапись);
	КонецЕсли;
	
	ИдентификаторСервера = ОбщегоНазначения.ИдентификаторХранилищаИзКонтроллера(ЭтотОбъект);
	СписокСерверовХранилищ = ОбщегоНазначения.СписокСерверовХранилищ();
	
	Модель = ОбщегоНазначения.МодельСтраницы(ЗаголовокСписка);
	Модель.Вставить("Серверы", СписокСерверовХранилищ);
	Модель.Вставить("ТекущийСервер", ИдентификаторСервера);
	Модель.Вставить("Запись", Запись);
	Модель.Вставить("ЗаголовокЗаписи", "Существующая запись");
	
	Возврат Представление("element", Модель);
	
КонецФункции

Функция Remove() Экспорт
	
	Если ЭтотОбъект.ЗапросHTTP.Метод = "POST" Тогда
		ИдентификаторЗаписи = ЭтотОбъект.ЗапросHTTP.ДанныеФормы["Идентификатор"]; // ???
		Если ЗначениеЗаполнено(ИдентификаторЗаписи) Тогда
			СуществующаяЗапись = МенеджерБазДанных.ХранилищеПоИдентификатору(ИдентификаторЗаписи);
			Если СуществующаяЗапись <> Неопределено Тогда
				МенеджерБазДанных.МенеджерСущностей.Удалить(СуществующаяЗапись);
			КонецЕсли;
		КонецЕсли;	
	КонецЕсли;
	
	Возврат Index();
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыФункции

Функция ШаблонЗаписи()
	
	Шаблон = Новый Структура;
	
	Шаблон.Вставить("Имя");
	Шаблон.Вставить("Идентификатор");
	Шаблон.Вставить("Сервер");
	Шаблон.Вставить("Путь");
	Шаблон.Вставить("Пользователь");
	Шаблон.Вставить("ХешПароля");
	Шаблон.Вставить("Комментарий");
	
	Возврат Шаблон;
	
КонецФункции

Функция СтрокаСпискаИзЗаписи(Запись)
	
	Ссылка = ОбщегоНазначения.ПутьКХранилищуКонфигурации(Запись);

	СтрокаСписка = Новый Структура();
	
	СтрокаСписка.Вставить("Имя"            , Запись.Имя);
	СтрокаСписка.Вставить("Идентификатор"  , Запись.Идентификатор);
	СтрокаСписка.Вставить("Ссылка"         , Ссылка);
	СтрокаСписка.Вставить("Пользователь"   , Запись.Пользователь);
	СтрокаСписка.Вставить("Комментарий"    , Запись.Комментарий);
	
	Возврат СтрокаСписка;
	
КонецФункции

#КонецОбласти

ЗаголовокСписка = "Список хранилищ конфигураций";
ЗаголовокЗаписи = "Хранилище конфигурации";