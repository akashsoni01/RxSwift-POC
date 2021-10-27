/*
 Copyright © 2017 Optimac, Inc. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation
import RxSwift
import RxDataSources

class Model {
    
    let data = Observable.just([
        SectionModel(model: "A", items: [
            Contributor(name: "Alex V Bush", gitHubID: "alexvbush"),
            Contributor(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            Contributor(name: "Anton Efimenko", gitHubID: "reloni"),
            Contributor(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        SectionModel(model: "B", items: [
            Contributor(name: "Ben Emdon", gitHubID: "BenEmdon"),
            Contributor(name: "Bob Spryn", gitHubID: "sprynmr"),
            ]),
        SectionModel(model: "C", items: [
            Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
            Contributor(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
            Contributor(name: "Chris Jimenez", gitHubID: "PiXeL16"),
            Contributor(name: "Christian Tietze", gitHubID: "DivineDominion"),
            ]),
        SectionModel(model: "D", items: [
            Contributor(name: "だいちろ", gitHubID: "mokumoku"),
            Contributor(name: "David Alejandro", gitHubID: "davidlondono"),
            Contributor(name: "David Paschich", gitHubID: "dpassage"),
            ]),
        SectionModel(model: "E", items: [
            Contributor(name: "Esteban Torres", gitHubID: "esttorhe"),
            Contributor(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            ]),
        SectionModel(model: "F", items: [
            Contributor(name: "Florent Pillet", gitHubID: "fpillet"),
            Contributor(name: "Francis Chong", gitHubID: "siuying"),
            ]),
        SectionModel(model: "G", items: [
            Contributor(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
            Contributor(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
            Contributor(name: "Gwendal Roué", gitHubID: "groue"),
            ]),
        SectionModel(model: "H", items: [
            Contributor(name: "Hiroshi Kimura", gitHubID: "muukii"),
            ]),
        SectionModel(model: "I", items: [
            Contributor(name: "Ivan Bruel", gitHubID: "ivanbruel"),
            ]),
        SectionModel(model: "J", items: [
            Contributor(name: "Jeon Suyeol", gitHubID: "devxoul"),
            Contributor(name: "Jérôme Alves", gitHubID: "jegnux"),
            Contributor(name: "Jesse Farless", gitHubID: "solidcell"),
            Contributor(name: "Junior B.", gitHubID: "bontoJR"),
            Contributor(name: "Justin Swart", gitHubID: "justinswart"),
            ]),
        SectionModel(model: "K", items: [
            Contributor(name: "Karlo", gitHubID: "floskel"),
            Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher"),
            ]),
        SectionModel(model: "L", items: [
            Contributor(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            Contributor(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
            Contributor(name: "Leo Picado", gitHubID: "leopic"),
            Contributor(name: "Libor Huspenina", gitHubID: "libec"),
            Contributor(name: "Lukas Lipka", gitHubID: "lipka"),
            Contributor(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
            ]),
        SectionModel(model: "M", items: [
            Contributor(name: "Marin Todorov", gitHubID: "icanzilb"),
            Contributor(name: "Maurício Hanika", gitHubID: "mAu888"),
            Contributor(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            ]),
        SectionModel(model: "N", items: [
            Contributor(name: "Nathan Kot", gitHubID: "nathankot"),
            ]),
        SectionModel(model: "O", items: [
            Contributor(name: "Orakaro", gitHubID: "DTVD"),
            Contributor(name: "Orta", gitHubID: "orta"),
            ]),
        SectionModel(model: "P", items: [
            Contributor(name: "Paweł Urbanek", gitHubID: "pawurb"),
            Contributor(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            Contributor(name: "PG Herveou", gitHubID: "pgherveou"),
            ]),
        SectionModel(model: "R", items: [
            Contributor(name: "Rui Costa", gitHubID: "ruipfcosta"),
            Contributor(name: "Ryo Fukuda", gitHubID: "yuzushioh"),
            ]),
        SectionModel(model: "S", items: [
            Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
            Contributor(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
            Contributor(name: "Sendy Halim", gitHubID: "sendyhalim"),
            Contributor(name: "Serg Dort", gitHubID: "sergdort"),
            Contributor(name: "Shai Mishali", gitHubID: "freak4pc"),
            Contributor(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
            Contributor(name: "Shenghan Chen", gitHubID: "zzdjk6"),
            Contributor(name: "Shunki Tan", gitHubID: "milkit"),
            Contributor(name: "Spiros Gerokostas", gitHubID: "sger"),
            Contributor(name: "Stefano Mondino", gitHubID: "stefanomondino"),
            ]),
        SectionModel(model: "T", items: [
            Contributor(name: "Thane Gill", gitHubID: "thanegill"),
            Contributor(name: "Thomas Duplomb", gitHubID: "tomahh"),
            Contributor(name: "Tomasz Pikć", gitHubID: "pikciu"),
            Contributor(name: "Tony Arnold", gitHubID: "tonyarnold"),
            Contributor(name: "Torsten Curdt", gitHubID: "tcurdt"),
            ]),
        SectionModel(model: "V", items: [
            Contributor(name: "Vladimir Burdukov", gitHubID: "chipp"),
            ]),
        SectionModel(model: "W", items: [
            Contributor(name: "Wolfgang Lutz", gitHubID: "Lutzifer"),
            ]),
        SectionModel(model: "X", items: [
            Contributor(name: "xixi197 Nova", gitHubID: "xixi197"),
            ]),
        SectionModel(model: "Y", items: [
            Contributor(name: "Yongha Yoo", gitHubID: "inkyfox"),
            Contributor(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
            Contributor(name: "Yury Korolev", gitHubID: "yury"),
            ]),
        ])
}
