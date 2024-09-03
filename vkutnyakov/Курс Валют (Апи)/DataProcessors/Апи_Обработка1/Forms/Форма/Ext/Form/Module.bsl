﻿
&НаКлиенте
Процедура ПолучитьДанные(Команда)
	ПолучитьДанныеНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПолучитьДанныеНаСервере()	
	
	ЗащищеноеСоединение = Новый ЗащищенноеСоединениеOpenSSL();
	//Попытка
		HTTP = Новый HTTPСоединение("api.coindesk.com",443,,,, 30,ЗащищеноеСоединение,);
		ЗапросHTTP = Новый HTTPЗапрос();
		ЗапросHTTP.АдресРесурса = "/v1/bpi/currentprice.json";
		//ЗапросHTTP.Заголовки.Вставить("Content-Type","text/html; charset=utf-8");
		HTTPОтвет = HTTP.Получить(ЗапросHTTP);
		//HTTPОтвет = HTTP.ВызватьHTTPМетод("GET",ЗапросHTTP);
		Если  HTTPОтвет.КодСостояния = 200 Тогда
			Результат = HTTPОтвет.ПолучитьТелоКакСтроку();
			
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(Результат);
			
			Курсы = ПрочитатьJSON(ЧтениеJSON);			
		КонецЕсли;
	//Исключение
	//	ТекстОшибки = КраткоеПредставлениеОшибки(ОписаниеОшибки());
	//КонецПопытки;
	
    СтруктКурсы = Курсы.bpi;
	
	Объект.ВалютаИКурсы.Очистить();
	
	Для Каждого СтрокаКурсы Из СтруктКурсы Цикл
		ДобавляемКурсы = Объект.ВалютаИКурсы.Добавить();
		
		ДобавляемКурсы.Валюта 		= СтрокаКурсы.Ключ;
		ДобавляемКурсы.Курс 		= СтрокаКурсы.Значение.rate_float;
		ДобавляемКурсы.Кратность 	= 1;		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьКурс(Команда)
	ЗаписатьКурсНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаписатьКурсНаСервере()
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Валюты.Ссылка КАК Ссылка,
		|	Валюты.Наименование КАК Наименование
		|ИЗ
		|	Справочник.Валюты КАК Валюты";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ТаблицаВалют = РезультатЗапроса.Выгрузить();
	
	Для каждого СтрокаТЧ Из Объект.ВалютаИКурсы Цикл
		СсылкаВалюта = ТаблицаВалют.Найти(СтрокаТЧ.Валюта,"Наименование");	
		Если СсылкаВалюта <> Неопределено Тогда 
			Запись = РегистрыСведений.КурсыВалют.СоздатьМенеджерЗаписи();
			
			Запись.Период = ТекущаяДата();
			Запись.Валюта = СсылкаВалюта.Ссылка;
			Запись.Курс = СтрокаТЧ.Курс;
			Запись.Кратность = СтрокаТЧ.Кратность;
			
			Запись.Записать();
		КонецЕсли;
	КонецЦикла;


КонецПроцедуры
