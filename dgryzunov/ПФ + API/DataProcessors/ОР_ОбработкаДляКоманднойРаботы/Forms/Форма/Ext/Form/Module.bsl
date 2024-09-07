﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Команда 			= Команды.Добавить("КомандаДляПримера"); 
	Команда.Заголовок 	= "Команда для примера";
	Команда.Действие  	= "КомандаДляПримера";
		
	КнопкаФормы 			= Элементы.Добавить("КомандаДляПримера" , Тип("КнопкаФормы"), ЭтаФорма);	
	КнопкаФормы.ИмяКоманды 	= "КомандаДляПримера";
	КнопкаФормы.Вид 		= ВидКнопкиФормы.ОбычнаяКнопка;   
	
	КомандаГрызунов 			= Команды.Добавить("ГрызуновДВ"); 
	КомандаГрызунов.Заголовок 	= "Грызунов Д.В.";
	КомандаГрызунов.Действие  	= "ГрызуновДВ";
		
	КнопкаФормыГрызунов 			= Элементы.Добавить("ГрызуновДВ" , Тип("КнопкаФормы"), ЭтаФорма);	
	КнопкаФормыГрызунов.ИмяКоманды 	= "ГрызуновДВ";
	КнопкаФормыГрызунов.Вид 		= ВидКнопкиФормы.ОбычнаяКнопка;     

		
КонецПроцедуры  

&НаКлиенте
Процедура КомандаДляПримера(Команда)
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Помещение в GIT выполнено. Исполнитель Попов А.В.'"));
	
КонецПроцедуры 

&НаКлиенте
Процедура ГрызуновДВ(КомандаГрызунов)
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Помещение в GIT выполнено. Исполнитель Грызунов Д.В.'"));
	
КонецПроцедуры