//
//  ContentView.swift
//  SwiftUIScrollView
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Spacer()
                
                Text("HORIZONTAL")
                CustomScrollView(.horizontal) {
                    Group {
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsja")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                    Group {
                        Text("1111  abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                }
                .border(Color.black, width: 0.5)
                .padding(.horizontal)
                
                Spacer()
                
                Text("VERTICAL")
                CustomScrollView {
                    Group {
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsja")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                    Group {
                        Text("1111  abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                    Group {
                        Text("22222    abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                    Group {
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                    Group {
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                        Text("abcjfkdlsa fjdksl;fjd l;fjdakl;fd sjak")
                            .background(Color.red)
                        Text("def fdklsjafdklsa fjdsla;")
                            .background(Color.green)
                        Text("ghi fdjlsajfdsklf jdsa")
                            .background(Color.red)
                        Text("jklfd sjklfdsjl")
                            .background(Color.green)
                        Text("mnojfdklsjfdkslfj")
                            .background(Color.red)
                    }
                }
                .frame(maxHeight: geo.size.height * 0.6)
                .border(Color.black, width: 0.5)
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
