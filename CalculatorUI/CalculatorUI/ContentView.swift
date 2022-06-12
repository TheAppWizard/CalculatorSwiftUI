//
//  ContentView.swift
//  CalculatorUI
//
//  Created by Shreyas Vilaschandra Bhike on 04/04/22.

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408


import SwiftUI

struct ContentView: View {
    var body: some View {
        CalculatorUI()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





























extension Color {
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topTrailing, endPoint: .bottomTrailing)
    }
}

// DarkBackgroundButton and Shapes
struct DarkBackground<myShape: Shape>: View {
    var isTapped: Bool
    var shape: myShape

    var body: some View {
        ZStack {
            if isTapped {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                      
                    .shadow(color: Color.darkStart, radius: 10, x: -5, y: -5)
                    .shadow(color: Color.darkEnd, radius: 5, x: -5, y: -5)
                
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                      
                    
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                    
            }
        }
    }
}

struct DarkButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
    
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 35))
            .frame(width: 87, height: 85, alignment: .center)
            .background(
                DarkBackground(isTapped: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 35))
            )
        
      
       }
    }

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "A/C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    

    var buttonColor: Color {
        switch self
        {
        case .clear :
            return .orange
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case  .negative, .percent:
            return Color.white
        default:
            return Color.white
        }
    }
    
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct CalculatorUI: View {

    @State var value = "0"
    @State var operationname = ""
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            
            LinearGradient(Color.darkStart, Color.darkEnd).edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                ZStack{
                    
                RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color("calcbg"))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15).stroke(.black, lineWidth: 5)
                                   }
                       
                       
               
                    HStack {
                    Spacer()
                    
                
                    Text(value)
                        .font(.custom("digital-7", size: 100))
                        .foregroundColor(.black)
                        .frame( height: 200)
                   
                    }
                    .offset(x: -10, y:-10)
        
                    .padding(10)
                    
                
                    HStack{
                        Image(systemName: "play.fill")
                            .foregroundColor(.black)
                            .font(.title2)
                        
                        Text(operationname)
                            .foregroundColor(.black)
                            .font(.custom("digital-7", size: 40))
                        
                        Spacer()
                    }.padding()
                        .offset(x: 0, y: 110)
                    
                  
                }.padding()
                
                Spacer().frame(width: 0, height: 20)
                
                
                
        

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 18) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundColor(item.buttonColor)
                                    
                                
                                    
                                    
                            }).buttonStyle(DarkButton())
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            
            
            
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "ADD"
                
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "SUBTRACT"
            }
            else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "MULTIPLY"
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "DIVIDE"
            }
            
            
            
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                   
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                    
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                   
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                    
                case .none:
                    break
                }
                self.operationname = "EQUAL"
            }

            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            self.operationname = "CLEAR"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
        
        
    }

}

