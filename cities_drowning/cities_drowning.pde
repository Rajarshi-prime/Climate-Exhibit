float popmax = 0.01*width;
float notsub;
color c1 = #fcbf49;
color c2 = #e63946;
int ncities = 5;
float sHeight = 0.1;
float sHeight0 = sHeight; 
float sHeightmax = 0.5;
float theta;
float popChange = 0.0 ;
float [] phase = new float[500];
float colwidth;
boolean reset = false;
float rstPosx = 0.92;
float rstPosy = 0.05;
float rstlen = 0.06;
float rstbreadth = 0.02;
float rstTxtsize = 0.152*width;
boolean firstMousePress = false;
float scrx = 0.08;
float scry = rstPosy+ rstbreadth/2;
float scrw = 0.2;
float scrh = rstbreadth;
float sposMin ;
float sposMax ;


city [] cities;
HScrollbar hs1;
void setup(){
  size(1200,900);
  background(255);
  frameRate(60);
  
  // float frameCount = frameCount*2;
  sea(sHeight);
  colwidth = int(0.9*width/ncities);
  cities = new city[ncities];
  hs1 = new HScrollbar(scrx,scry, scrw, scrh, 16);
  theta = PI*height/(6*width);
  String [] cnames = loadStrings("./data/cities.txt");
  for (int i=0;i<ncities;++i){
  
    cities[i] = new city(random(0.7)+ sHeight , i,random(0.3*popmax, popmax),cnames[i]);
    cities[i].show();
  }
  
  for(int i=0; i<500; ++i)
  phase[i] = random(TWO_PI);
  
}
void draw(){
  fill(255,190);
  rect(-0.001*width, -0.001*height,width*1.002,height*1.002);  
  resetbtn();
  
  
  if (reset){
    notsub = 5;
    popChange = 0;
    sHeight = sHeight0;
    hs1.reset();
    for (int i=0;i<ncities;++i){
      cities[i].reset();
    }
}
  hs1.update();
  hs1.display();
  sHeight = map(hs1.getPos(),sposMin, sposMax,sHeight0,sHeightmax);
  println(hs1.getPos()/sposMin);
  //sHeight = 0.5;
  for (int i=0;i<ncities;++i){
    cities[i].changePop();  
}

  for (int i=0;i<ncities;++i){
    cities[i].feedPop();
    cities[i].show();
}
sea(sHeight);

notsub = 0;
popChange = 0.0;
reset = false;
firstMousePress = false;
}

void mousePressed() {
    //sHeight = 1- mouseY/(1.0*height);
    //sHeight =  map(1-mouseY/(1.0*height), 0, 1, 0, 0.4);

  if (!firstMousePress) {
    firstMousePress = true;
  }
} 

void mouseDragged() {
    //sHeight = 1- mouseY/(1.0*height);
    if(mouseY>height*sHeightmax) 
    sHeight = 1- mouseY/(1.0*height);
    //sHeight =  map(1-mouseY/(1.0*height), 0, 1, 0, 0.4);
} 
void mouseClicked(){
        if (mouseX > rstPosx*width && mouseX < (rstPosx + rstlen)*width && mouseY > rstPosy*height && mouseY < (rstPosy + rstbreadth)*height  ) {
      reset = true;
      // print("YAY!!");
    }
  }
  
