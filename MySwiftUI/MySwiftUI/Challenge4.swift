import SwiftUI

struct Challenge4: View {
    let weather = Weather()
    var body: some View {
        VStack {
            CurrentConditions(forecast: weather.hourlyForecast[0])
            Divider()
            HStack {
                ForEach(weather.hourlyForecast) { forecast in
                    ForecasatView(forecast: forecast)
                }
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(Color(.lightBlue))
    }
}

struct ForecasatView: View {
    let forecast: Weather.Forecast
    var body: some View {
        VStack {
            Text(forecast.hour)
            forecast.conditions
                .renderingMode(.original)
            Text(forecast.temperature)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Weather {
    struct Forecast: Identifiable {
        let id = UUID().uuidString
        let hour: String
        let conditions: Image
        let temperature: String
    }
    
    let hourlyForecast = [
        Forecast(hour: "8AM", conditions: Image(systemName: "sun.max.fill"), temperature: "63°"),
        Forecast(hour: "9AM", conditions: Image(systemName: "cloud.sun.fill"), temperature: "63°"),
        Forecast(hour: "10AM", conditions: Image(systemName: "sun.max.fill"), temperature: "64°"),
        Forecast(hour: "11AM", conditions: Image(systemName: "cloud.fill"), temperature: "61°"),
        Forecast(hour: "12PM", conditions: Image(systemName: "cloud.rain.fill"), temperature: "62°")
    ]
}

#Preview {
    Challenge4()
}


struct CurrentConditions: View {
    let forecast: Weather.Forecast
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack {
                Text("Cupertino").font(.title3)
                Text(forecast.temperature).font(.largeTitle)
            }
            Spacer()
            VStack(alignment: .trailing) {
                forecast.conditions.renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Sunny")
                Text("H: 68º L:42º")
            }
        }
    }
}
