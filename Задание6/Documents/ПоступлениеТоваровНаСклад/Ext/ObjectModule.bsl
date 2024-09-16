﻿&Перед("ОбработкаПроведения")
Процедура ШСВ_ОбработкаПроведения(Отказ, РежимПроведения)
	Движения.ШСВ_ОстаткиНоменклатуры.Записывать = Истина;
	
	Для каждого ТекСтрока Из Товары Цикл
	
		Движение = Движения.ШСВ_ОстаткиНоменклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрока.Номенклатура;
		Движение.Склад = Склад;
		Движение.Организация = Организация;
		Движение.Количество = ТекСтрока.Количество;
	
	КонецЦикла;
	
КонецПроцедуры
