﻿
Процедура НСМ1_МетодикиОбработкаПроведения(Источник, Отказ, РежимПроведения) Экспорт 
	Если Источник.НСМ1_Методики = Перечисления.НСМ1_Методики.Старая Тогда
		Источник.Движения.НСМ1_ОстаткиНоменклатуры.Записывать = Истина;
		Источник.Движения.НСМ1_ОстаткиНоменклатуры.Очистить();
		Источник.Движения.НСМ1_ОстаткиНоменклатуры.Записать();
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	РеализацияТоваровУслугТовары.Номенклатура КАК Номенклатура,
			|	СУММА(РеализацияТоваровУслугТовары.Количество) КАК Количество
			|ПОМЕСТИТЬ ВТ_ТовырыДок
			|ИЗ
			|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
			|ГДЕ
			|	РеализацияТоваровУслугТовары.Ссылка = &Ссылка
			|
			|СГРУППИРОВАТЬ ПО
			|	РеализацияТоваровУслугТовары.Номенклатура
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	НСМ1_ОстаткиНоменклатурыОстатки.Номенкулатура КАК Номенкулатура,
			|	НСМ1_ОстаткиНоменклатурыОстатки.КоличествоОстаток КАК КоличествоОстаток
			|ПОМЕСТИТЬ ВТ_Остатки
			|ИЗ
			|	РегистрНакопления.НСМ1_ОстаткиНоменклатуры.Остатки(
			|			&Период,
			|			(Склад, Организация, Номенкулатура) В
			|				(ВЫБРАТЬ
			|					&Склад,
			|					&Организация,
			|					ВТ_ТовырыДок.Номенклатура КАК Номенклатура
			|				ИЗ
			|					ВТ_ТовырыДок КАК ВТ_ТовырыДок)) КАК НСМ1_ОстаткиНоменклатурыОстатки
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ПРЕДСТАВЛЕНИЕ(ВТ_ТовырыДок.Номенклатура) КАК Номенклатура,
			|	ВТ_ТовырыДок.Количество КАК КоличествоДок,
			|	ЕСТЬNULL(ВТ_Остатки.КоличествоОстаток, 0) КАК КоличествоОстаток
			|ИЗ
			|	ВТ_ТовырыДок КАК ВТ_ТовырыДок
			|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Остатки КАК ВТ_Остатки
			|		ПО ВТ_ТовырыДок.Номенклатура = ВТ_Остатки.Номенкулатура";
		
		Запрос.УстановитьПараметр("Склад",Источник.Склад);
		Запрос.УстановитьПараметр("Период",Источник.Дата);
		Запрос.УстановитьПараметр("Организация", Источник.Организация);
		Запрос.УстановитьПараметр("Ссылка",Источник.Ссылка);
		
		//ирОбщий.От(Запрос, , , ,)
		РезультатЗапроса = Запрос.Выполнить();
		Выборка = РезультатЗапроса.Выбрать();
		
		Пока Выборка.Следующий() цикл
			Если Выборка.КоличествоДок > Выборка.КоличествоОстаток Тогда
				ВМинусе = Выборка.КоличествоДок - Выборка.КоличествоОстаток;
				СтрокаОшики = "ОтказСтарой" + ВМинусе;
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаОшики);
				Отказ = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если Отказ = Ложь Тогда
			Для Каждого ТекСтрокаТовар Из Источник.Товары Цикл
				Движение = Источник.Движения.НСМ1_ОстаткиНоменклатуры.Добавить();
				Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
				Движение.Период = Источник.Дата;
				Движение.Номенкулатура = ТекСтрокаТовар.Номенклатура;
				Движение.Организация = Источник.Организация; 
				Движение.Склад = Источник.Склад;
				Движение.Количество = ТекСтрокаТовар.Количество;
			КонецЦикла;	
		КонецЕсли; 
	Иначе
		МенеджерВТ = Новый МенеджерВременныхТаблиц;
		Запрос = Новый Запрос;
		Запрос.МенеджерВременныхТаблиц = МенеджерВТ;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	РеализацияТоваровУслугТовары.Номенклатура КАК Номенклатура,
			|	СУММА(РеализацияТоваровУслугТовары.Количество) КАК Количество
			|ПОМЕСТИТЬ ВТ_ТоварыДокумента
			|ИЗ
			|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
			|ГДЕ
			|	РеализацияТоваровУслугТовары.Ссылка = &Ссылка
			|
			|СГРУППИРОВАТЬ ПО
			|	РеализацияТоваровУслугТовары.Номенклатура
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ВТ_ТоварыДокумента.Номенклатура КАК Номенклатура,
			|	ВТ_ТоварыДокумента.Количество КАК Количество
			|ИЗ
			|	ВТ_ТоварыДокумента КАК ВТ_ТоварыДокумента";
		
		Запрос.УстановитьПараметр("Ссылка", Источник.Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Выборка = РезультатЗапроса.Выбрать();
		
		Источник.Движения.НСМ1_ОстаткиНоменклатуры.Записывать = Истина;
		Пока Выборка.Следующий() Цикл
			Движение = Источник.Движения.НСМ1_ОстаткиНоменклатуры.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Источник.Дата;
			Движение.Номенкулатура = Выборка.Номенклатура;
			Движение.Организация = Источник.Организация; 
			Движение.Склад = Источник.Склад;
			Движение.Количество = Выборка.Количество;
		КонецЦикла;
		Источник.Движения.НСМ1_ОстаткиНоменклатуры.Записать();
			
		Запрос = Новый Запрос;
		Запрос.МенеджерВременныхТаблиц = МенеджерВТ;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	ПРЕДСТАВЛЕНИЕ(НСМ1_ОстаткиНоменклатурыОстатки.Номенкулатура) КАК Номенкулатура,
			|	-НСМ1_ОстаткиНоменклатурыОстатки.КоличествоОстаток КАК Дефицит
			|ИЗ
			|	РегистрНакопления.НСМ1_ОстаткиНоменклатуры.Остатки(
			|			&Период,
			|			(Склад, Организация, Номенкулатура) В
			|				(ВЫБРАТЬ
			|					&Склад,
			|					&Организация,
			|					ВТ_ТоварыДокумента.Номенклатура КАК Номенкулатура
			|				ИЗ
			|					ВТ_ТоварыДокумента КАК ВТ_ТоварыДокумента)) КАК НСМ1_ОстаткиНоменклатурыОстатки
			|ГДЕ
			|	НСМ1_ОстаткиНоменклатурыОстатки.КоличествоОстаток < 0";
		
		Период = Новый Граница(Источник.МоментВремени(),ВидГраницы.Включая);
		
		Запрос.УстановитьПараметр("Организация", Источник.Организация);
		Запрос.УстановитьПараметр("Период",Период);
		Запрос.УстановитьПараметр("Склад", Источник.Склад);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Если не РезультатЗапроса.Пустой() Тогда
			Отказ = Истина;
			
			Выборка = РезультатЗапроса.Выбрать();
			Пока Выборка.Следующий() Цикл
				ВМинусе = Выборка.КоличествоДок - Выборка.Дефицит;
				СтрокаОшики = "ОтказНовой" + ВМинусе;
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаОшики);	
			КонецЦикла;

		КонецЕсли;
	КонецЕсли
КонецПроцедуры 


Процедура НСМ1_ДобовлениеОбработкаПроведения(Источник, Отказ, РежимПроведения) Экспорт
	Источник.Движения.НСМ1_ОстаткиНоменклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаТовар Из Источник.Товары Цикл
		Движение = Источник.Движения.НСМ1_ОстаткиНоменклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Источник.Дата;
		Движение.Номенкулатура = ТекСтрокаТовар.Номенклатура;
		Движение.Организация = Источник.Организация;
		Движение.Склад = Источник.Склад ;
		Движение.Количество = ТекСтрокаТовар.Количество ;
	КонецЦикла;
КонецПроцедуры

