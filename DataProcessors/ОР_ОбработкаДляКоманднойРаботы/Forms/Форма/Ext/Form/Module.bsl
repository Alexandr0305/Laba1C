﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Команда 			= Команды.Добавить("КомандаДляПримера"); 
	Команда.Заголовок 	= "Команда для примера";
	Команда.Действие  	= "КомандаДляПримера";
		
	КнопкаФормы 			= Элементы.Добавить("КомандаДляПримера" , Тип("КнопкаФормы"), ЭтаФорма);	
	КнопкаФормы.ИмяКоманды 	= "КомандаДляПримера";
	КнопкаФормы.Вид 		= ВидКнопкиФормы.ОбычнаяКнопка;     
		
КонецПроцедуры  

&НаКлиенте
Процедура КомандаДляПримера(Команда)
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru='Помещение в GIT выполнено. Исполнитель Попов А.В.'"));
	
КонецПроцедуры