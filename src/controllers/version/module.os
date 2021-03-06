#Использовать "../../model"

#Область ОписаниеПеременных

Перем ЗаголовокСтраницы; // заголовок страницы по адресу /repo/index

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Обработчик действия index (список хранилищ 1С)
//
Функция Index() Экспорт

	ИдентификаторХранилища = ОбщегоНазначения.ИдентификаторХранилищаИзКонтроллера(ЭтотОбъект);
	ХранилищеКонфигурации = ОбщегоНазначения.ХранилищеКонфигурацииПоИд(ИдентификаторХранилища);
	СписокХранилищКонфигурации = ОбщегоНазначения.СписокХранилищКонфигурации();

	Если ИдентификаторХранилища = Неопределено И СписокХранилищКонфигурации.Количество() > 0 Тогда
		Возврат Перенаправление(СтрШаблон("/%1/version", СписокХранилищКонфигурации[0].Идентификатор));
	КонецЕсли;

	СписокВерсий = ОбщегоНазначения.СписокВерсийПоХранилищу(ХранилищеКонфигурации);

	Модель = ОбщегоНазначения.МодельСтраницы(ЗаголовокСтраницы);
	Модель.Вставить("СписокХранилищ", СписокХранилищКонфигурации);
	Модель.Вставить("ТекущееХранилище", ИдентификаторХранилища);
	Модель.Вставить("Список", СписокВерсий);

	Возврат Представление("page", Модель);

КонецФункции

#КонецОбласти

ЗаголовокСтраницы = "История версий";