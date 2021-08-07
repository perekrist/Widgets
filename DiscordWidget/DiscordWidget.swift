//
//  DiscordWidget.swift
//  DiscordWidget
//
//  Created by wsa2021 on 02.08.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), usersCount: 5, configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), usersCount: 5, configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        for index in 0 ..< 120 {
            let entryDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, usersCount: 5 - index%5,
                                    configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let usersCount: Int
    let configuration: ConfigurationIntent
}

struct DiscordWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    let columns = [
        GridItem(.adaptive(minimum: 63))
    ]
    
    var body: some View {
        switch family {
        case .systemMedium:
            ZStack {
                Color(#colorLiteral(red: 0.1823562682, green: 0.1921957433, blue: 0.2136486173, alpha: 1)).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Image("logo")
                            .padding(11)
                        VStack(alignment: .leading) {
                            Text("Megabox")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            Text("# Game_chat_1")
                                .font(.system(size: 13))
                                .foregroundColor(Color(#colorLiteral(red: 0.4480345249, green: 0.4628567696, blue: 0.4928785563, alpha: 1)))
                        }
                        Spacer()
                        Link(destination: URL(string: "widget-deeplink://voice\(entry.usersCount)")!) {
                            Text("Join Voice")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(Color(#colorLiteral(red: 0.4430701733, green: 0.5380838513, blue: 0.8535925746, alpha: 1)))
                                .cornerRadius(16.5)
                                .padding(.trailing, 11)
                        }
                    }.background(Color(#colorLiteral(red: 0.1234568134, green: 0.1335066855, blue: 0.1462851763, alpha: 1)))
                    HStack {
                        ForEach(users.prefix(entry.usersCount), id: \.icon) { user in
                            Image(user.icon)
                                .resizable()
                                .frame(width: 33, height: 33)
                        }
                    }.padding(.leading, 11)
                    .padding(.top, 13)
                    Spacer()
                }
            }
        case .systemSmall:
            ZStack(alignment: .bottom) {
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: .infinity)
                HStack {
                    Image("logo")
                        .padding(.top, 12)
                        .padding([.leading, .bottom], 5.5)
                    Spacer()
                    VStack(alignment: .center) {
                        ZStack {
                            ForEach(0..<entry.usersCount, id: \.self) { index in
                                Image(users[index].icon)
                                    .resizable()
                                    .frame(width: 33, height: 33)
                                    .overlay(
                                        Circle()
                                            .stroke(Color(#colorLiteral(red: 0.143135488, green: 0.1529731154, blue: 0.1744169593, alpha: 1)), lineWidth: 3)
                                    )
                                    .offset(x: -CGFloat(index*10))
                            }
                        }
                        Text("\(entry.usersCount) online")
                            .font(.system(size: 13))
                            .foregroundColor(Color(#colorLiteral(red: 0.4401913881, green: 0.4550128579, blue: 0.4850346446, alpha: 1)))
                            .padding(.trailing, 35)
                            .padding(.bottom, 9)
                    }.padding(.top, 12)
                }
                .background(Color(#colorLiteral(red: 0.143135488, green: 0.1529731154, blue: 0.1744169593, alpha: 1)))
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(Color(#colorLiteral(red: 0.1823562682, green: 0.1921957433, blue: 0.2136486173, alpha: 1)), lineWidth: 4)
                )
            }.overlay(
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color(#colorLiteral(red: 0.1823562682, green: 0.1921957433, blue: 0.2136486173, alpha: 1)), lineWidth: 4)
            )
        case .systemLarge:
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7776217461, green: 0.22522071, blue: 0.6065708399, alpha: 1)), Color(#colorLiteral(red: 0.5477463007, green: 0.02614268288, blue: 0.7323881984, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                VStack {
                    ZStack {
                        HStack {
                            Image("main")
                                .resizable()
                                .frame(width: 126, height: 126)
                                .padding(.top, 16)
                                .padding(.leading, 18)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Spacer()
                                Text("RECENTLY PLAYED")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                                Text("Office Olympics w/ Paul Feig")
                                    .bold()
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                Text("Office Ladies")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                            }.padding(.horizontal, 17)
                        }
                        HStack {
                            Spacer()
                            VStack {
                                Image("podcast")
                                    .resizable()
                                    .frame(width: 26, height: 28)
                                    .padding(16)
                                Spacer()
                            }
                        }
                    }.padding(.bottom, 21)
                    .frame(height: 163)
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(0..<8, id: \.self) { index in
                            Image("small\(index)")
                                .resizable()
                                .frame(width: 63, height: 63)
                                .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 4)
                        }
                    }.padding([.horizontal, .bottom], 16)
                    .padding(.top, 25)
                    .background(Color.white.opacity(0.12))
                }
            }
            
        }
    }
    
    @main
    struct DiscordWidget: Widget {
        let kind: String = "DiscordWidget"
        
        var body: some WidgetConfiguration {
            IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
                DiscordWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
        }
    }
}
