-- Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
create table pracownicy (
	id_pracownika int primary key auto_increment,
    imie varchar(225) not null,
    nazwisko varchar(225) not null,
    wypłata int,
	data_urodzenia date not null,
    stanowisko varchar(225) not null
);

-- Wstawia do tabeli co najmniej 6 pracowników
insert into pracownicy(imie, nazwisko, wypłata, data_urodzenia, stanowisko) 
values  ('Adam', 'Adamski', 5000, '1980-07-01', 'kierownik'), 
		('Ania', 'Kowalska', 1000, '1980-02-22', 'dyrektor'),
		('Krzyś', 'Pałka', 4000, '1980-09-01', 'specjalista'),
		('Robert', 'Jak', 3000, '1980-03-07', 'młodszy specjalista'),
		('Janina', 'Kowalczyk', 7000, '1980-10-15', 'administrator it'),
		('Oliwia', 'Nowak', 0, '2000-01-01', 'praktykant');

-- Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
select * from pracownicy ORDER BY nazwisko ASC;

-- Pobiera pracowników na wybranym stanowisku
select * from pracownicy where stanowisko ='dyrektor';

-- Pobiera pracowników, którzy mają co najmniej 30 lat
select * from pracownicy
where timestampdiff(year, data_urodzenia, curdate()) >= 30;

-- Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
update pracownicy 
set wypłata = wypłata*1.1
where id_pracownika =1;

-- Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
select imie, nazwisko, data_urodzenia from pracownicy where data_urodzenia = (select  max(data_urodzenia) from pracownicy);

-- Usuwa tabelę pracownik
drop table pracownicy;

-- Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
create table stanowisko (
	id_stanowiska int primary key,
	nazwa varchar(225) not null,
    opis varchar(225) not null,
    wypłata int
);

-- Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
create table adres (
	kod_pocztowy varchar(5) not null,
    ulica_numer varchar(225) not null,
    miejscowość varchar(225) not null,
    id_adresu int primary key
);

-- Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
create table pracownik (
 imie varchar(20) not null,
 nazwisko varchar(50) not null,
 id_adresu int,
 id_stanowiska int,
 foreign key (id_adresu) references adres(id_adresu),
 foreign key (id_stanowiska) references stanowisko(id_stanowiska)
);

-- Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
insert into stanowisko (id_stanowiska, nazwa, opis, wypłata) 
values  (1,'kierownik', 'uszanowanko panie kierowniku', 5000), 
		(2,'dyrektor', 'no cóż o jedno 0 na wypłacie za mało', 1000),
		(3,'specjalista', 'wymądrza się ale przynajniej coś umie', 4000 ),
		(4,'młodszy specjalista', 'ledwo przyszedł a już się wymądrza', 3000 ),
		(5,'administrator it', 'bez niego wszystko się sypie', 7000 ),
		(6,'praktykant', 'tania siła robocza', 0);

insert into adres (kod_pocztowy, ulica_numer, miejscowość, id_adresu) 
values  ('00001', 'Świętokrzyska 15b/98', 'Warszawa', 1), 
		('00240', 'Aleja Solidarności 56/43', 'Warszawa', 2),
		('00085', 'Bielańska 10/56', 'Warszawa',3),
		('02192', 'Lajkonika 23/87', 'Warszawa',4),
		( '05090', 'Wspólna 45b', 'Janki',5);

insert into pracownik (imie, nazwisko, id_adresu, id_stanowiska) 
values  ('Adam', 'Adamski',  1, 1), 
		('Ania', 'Kowalska', 2, 2),
		('Krzyś', 'Pałka',3 , 3),
		('Robert', 'Jak', 4, 4),
		('Janina', 'Kowalczyk', 5, 5),
		('Oliwia', 'Nowak', 5, 6);

-- Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

select pracownik.imie, pracownik.nazwisko, adres.kod_pocztowy, adres.ulica_numer, adres.miejscowość, stanowisko.nazwa
from pracownik 
left join adres on pracownik.id_adresu= adres.id_adresu
right join stanowisko on pracownik.id_stanowiska=stanowisko.id_stanowiska
where pracownik.id_stanowiska='2' ;

-- Oblicza sumę wypłat dla wszystkich pracowników w firmie
select sum(wypłata) from stanowisko;

-- Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
select pracownik.imie, pracownik.nazwisko, adres.kod_pocztowy, adres.ulica_numer, adres.miejscowość 
from pracownik
left join adres on pracownik.id_adresu= adres.id_adresu
where kod_pocztowy = '05090';




