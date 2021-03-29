//
//  ContentView.swift
//  Movies_TuaiqCamp
//
//  Created by Abdullah Alnutayfi on 11/03/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mvm = MovieViewModel()
    @State var searchByName = ""
    @State var searchType = ""
    @State var searchBRrank = ""
    
    @State var name = ""
    @State var cat = ""
    @State var rank = ""
    @State var showSheet = false
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var mov_img : Image?
    @State var PickedImage : UIImage
    @State var sourceType:UIImagePickerController.SourceType = .camera
    var body: some View {
        
        NavigationView{
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Movie Name",text: $searchByName)
                    Divider()
                    TextField("Movie Categoery",text: $searchType)
                    Divider()
                    TextField("Movie Rank",text: $searchBRrank)
                    Button(action: {showSheet.toggle()}){
                        Text("+")
                            .font(Font.system(size: 20, weight: .bold, design: .default))
                    }.sheet(isPresented: $showSheet, content: {
                        VStack{
                            
                            Text("Add New Movie")
                            TextField("Movie name", text: $name)
                            TextField("Categoery", text: $cat)
                            TextField("rank", text: $rank)
                            
                            VStack{
                                if mov_img != nil{
                                    mov_img!
                                        .resizable()
                                        .frame(width: 300, height: 450, alignment: .center)
                                        .foregroundColor(.green)
                                    
                                }
                                else{
                                    
                                    Image(systemName: "text.below.photo.fill")
                                        
                                        .resizable()
                                        
                                        .scaledToFit()
                                        .padding()
                                        .frame(width: 200, height: 190)
                                        .padding()
                                        .clipShape(Circle())
                                        .foregroundColor(Color(.systemGreen))
                                        .opacity(0.90)
                                }
                            }
                            .onTapGesture {
                                showActionSheet.toggle()
                            }.actionSheet(isPresented: $showActionSheet, content: {
                                ActionSheet(title: Text("Choose a photo"), message: nil, buttons:
                                                [
                                                    .default(Text("Camera")){showImagePicker.toggle();sourceType = .camera},
                                                    .default(Text("Photo library")){showImagePicker.toggle();sourceType = .photoLibrary},
                                                    .cancel()
                                                ])
                            }
                            ).sheet(isPresented: $showImagePicker,onDismiss: loadImage, content: {
                                ImagePicker(sourceType: sourceType, selectedImage: $PickedImage)
                            })
                            Spacer()
                            Button("Add movie"){
                                
                                mvm.m_array.append(Movie(id: UUID().uuidString, movieName: name, category: cat, rank: rank,image: nil ,image2 : PickedImage))
                                showSheet = false
                                mov_img = nil
                                name = ""
                                cat = ""
                                rank = ""
                            }
                            Spacer()
                        }.padding()
                    })
                }.padding(5)
                .frame(width: UIScreen.main.bounds.width, height: 30)
                .font(Font.system(size: 12))
                List{
                    if searchByName == "" && searchType == "" && searchBRrank == "" {
                        ForEach(mvm.m_array) { movie in
                            VStack{
                                if movie.image != nil{
                                    Image(movie.image!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 80, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                else{
                                    Image(uiImage: movie.image2!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                    
                                }
                                HStack{
                                    Text(movie.movieName)
                                        .font(Font.system(size: 12, design: .monospaced))
                                        .frame(width: 200, height: 20)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                    
                                    Spacer()
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.yellow)
                                        Text("\(movie.rank)")
                                            .font(Font.system(size: 12, design: .monospaced))
                                        
                                    }.frame(width: 60, height: 17)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color:.black,radius: 10)
                                    .offset(x: -10)
                                    
                                }.padding(.leading)
                                HStack{
                                    Text(movie.category)
                                        .font(Font.system(size: 10, design: .monospaced))
                                        .frame(width: 200, height: 15)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .padding(.top, -5)
                                    Spacer()
                                }
                            }.listRowBackground(Color(.systemGray6))
                        }
                        .onDelete(perform: { indexSet in
                            self.mvm.m_array.remove(atOffsets: indexSet)
                        })
                    }
                    if searchByName != "" && searchType == "" && searchBRrank == "" {
                        ForEach(mvm.m_array.filter({$0.movieName.lowercased().contains(searchByName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))})) { movie in
                            VStack{
                                if movie.image != nil{
                                    Image(movie.image!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 80, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                else{
                                    Image(uiImage: movie.image2!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                HStack{
                                    Text(movie.movieName)
                                        .font(Font.system(size: 12, design: .monospaced))
                                        .frame(width: 200, height: 20)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                    
                                    Spacer()
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.yellow)
                                        Text("\(movie.rank)")
                                            .font(Font.system(size: 12, design: .monospaced))
                                        
                                    }.frame(width: 60, height: 17)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color:.black,radius: 10)
                                    .offset(x: -10)
                                    
                                }.padding(.leading)
                                HStack{
                                    Text(movie.category)
                                        .font(Font.system(size: 10, design: .monospaced))
                                        .frame(width: 200, height: 15)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .padding(.top, -5)
                                    Spacer()
                                }
                            }.listRowBackground(Color(.systemGray6))
                        }
                        .onDelete(perform: { indexSet in
                            self.mvm.m_array.remove(atOffsets: indexSet)
                        })
                    }
                    if searchByName == "" && searchType != "" && searchBRrank == "" {
                        ForEach(mvm.m_array.filter({$0.category.lowercased().contains(searchType.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))})) { movie in
                            VStack{
                                if movie.image != nil{
                                    Image(movie.image!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 80, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                else{
                                    Image(uiImage: movie.image2!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                HStack{
                                    Text(movie.movieName)
                                        .font(Font.system(size: 12, design: .monospaced))
                                        .frame(width: 200, height: 20)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                    
                                    Spacer()
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.yellow)
                                        Text("\(movie.rank)")
                                            .font(Font.system(size: 12, design: .monospaced))
                                        
                                    }.frame(width: 60, height: 17)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color:.black,radius: 10)
                                    .offset(x: -10)
                                    
                                }.padding(.leading)
                                HStack{
                                    Text(movie.category)
                                        .font(Font.system(size: 10, design: .monospaced))
                                        .frame(width: 200, height: 15)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .padding(.top, -5)
                                    Spacer()
                                }
                            }.listRowBackground(Color(.systemGray6))
                        }
                        .onDelete(perform: { indexSet in
                            self.mvm.m_array.remove(atOffsets: indexSet)
                        })
                    }
                    if searchByName == "" && searchType == "" && searchBRrank != "" {
                        ForEach(mvm.m_array.filter({$0.rank.lowercased().contains(searchBRrank.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))})) { movie in
                            VStack{
                                if movie.image != nil{
                                    Image(movie.image!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 80, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                else{
                                    Image(uiImage: movie.image2!)
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width - 70, height: 450, alignment: .center)
                                        //.offset(x: -20)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .padding(.top,5)
                                }
                                HStack{
                                    Text(movie.movieName)
                                        .font(Font.system(size: 12, design: .monospaced))
                                        .frame(width: 200, height: 20)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                    
                                    Spacer()
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.yellow)
                                        Text("\(movie.rank)")
                                            .font(Font.system(size: 12, design: .monospaced))
                                        
                                    }.frame(width: 60, height: 17)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color:.black,radius: 10)
                                    .offset(x: -10)
                                    
                                }.padding(.leading)
                                HStack{
                                    Text(movie.category)
                                        .font(Font.system(size: 10, design: .monospaced))
                                        .frame(width: 200, height: 15)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black,radius: 8)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                        .padding(.top, -5)
                                    Spacer()
                                }
                            }.listRowBackground(Color(.systemGray6))
                        }
                        .onDelete(perform: { indexSet in
                            self.mvm.m_array.remove(atOffsets: indexSet)
                        })
                    }
                }
                
                Spacer()
            }.navigationBarTitle(Text("Movies"),displayMode: .inline)
            // .padding()
            
            
        }
    }
    func loadImage()
    {
        mov_img = Image(uiImage: PickedImage)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(PickedImage: UIImage())
    }
}
