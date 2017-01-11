# BiletixTest
# Пример тестового задания с использование POST запросов и REST


----------------------------------------------------------------------------------
В качестве тестового задания необходимо отправить данные по адресу:
https://hotels.gate.biletix.ru/hotels/test/searchResultStat?apiKey=0b85bbb1a4c09536768e9c81161bf24a

POST запрос содержащий:
{"requests":[{"indexName":"airbnb","params":"query=%D0%A1%D0%B0%D0%BC%D0%B0%D1%80%D0%B0%20(%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D1%8F)&hitsPerPage=10&maxValuesPerFacet=10&page=0&facets=%5B%22stars%22%2C%22room_type%22%2C%22facilities%22%2C%22price%22%5D&tagFilters=&numericFilters=%5B%22AccommodationArrival%3D1485723600%22%2C%22AccommodationDeparture%3D1485810000%22%5D"}]}

получить результат, отобразить его в виде вариантов размещения с ценой и кнопкой.

при нажатии на кнопку "купить"- отображается произвольное сообщение.
