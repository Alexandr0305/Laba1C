﻿
Процедура ШСВ_ПодпискаНаСобытиеОтсутствиеРаботникаОбработкаПроведения(Источник, Отказ, РежимПроведения) Экспорт
	// Вставить содержимое обработчика.
	Док = Источник; 
	
	Если ТипЗнч(Док) = Тип("ДокументОбъект.БольничныйЛист") Тогда
		
		НовыйЭлементРС = РегистрыСведений.ШСВ_ОтсутствиеСотрудникаАстон.СоздатьМенеджерЗаписи();
		НовыйЭлементРС.Сотрудник = Источник.Сотрудник;
		НовыйЭлементРС.ДатаНачалаОтсутствия = Источник.ДатаНачала;
		НовыйЭлементРС.ДатаОкончанияОтсутствия = Источник.ДатаОкончания;
		НовыйЭлементРС.КоличествоДней = (НовыйЭлементРС.ДатаОкончанияОтсутствия - НовыйЭлементРС.ДатаНачалаОтсутствия) / 86400 + 1;
		НовыйЭлементРС.Записать();
		
	ИначеЕсли ТипЗнч(Док) = Тип("ДокументОбъект.Отпуск") Тогда
		
		НовыйЭлементРС = РегистрыСведений.ШСВ_ОтсутствиеСотрудникаАстон.СоздатьМенеджерЗаписи();
		НовыйЭлементРС.Сотрудник = Источник.Сотрудник;
		НовыйЭлементРС.ДатаНачалаОтсутствия = Источник.НачалоОтпуска;
		НовыйЭлементРС.ДатаОкончанияОтсутствия = Источник.ОкончаниеОтпуска;
		НовыйЭлементРС.КоличествоДней = (НовыйЭлементРС.ДатаОкончанияОтсутствия - НовыйЭлементРС.ДатаНачалаОтсутствия) / 86400 + 1;
		НовыйЭлементРС.Записать();
		
	Иначе
		
		НовыйЭлементРС = РегистрыСведений.ШСВ_ОтсутствиеСотрудникаАстон.СоздатьМенеджерЗаписи();
		НовыйЭлементРС.Сотрудник = Источник.Сотрудник;
		НовыйЭлементРС.ДатаНачалаОтсутствия = Источник.ДатаУвольнения;
		НовыйЭлементРС.ДатаОкончанияОтсутствия = Источник.ДатаУвольнения;
		НовыйЭлементРС.КоличествоДней = 0;
		НовыйЭлементРС.Записать();
		
	КонецЕсли;
	
КонецПроцедуры
