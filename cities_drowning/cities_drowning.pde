float popmax = 0.01*width;
float notsub;
color c1 = #fcbf49;
color c2 = #e63946;
int ncities = 5;
float sHeight = 0.1;
float theta  = PI*height/(6*width);
float popChange = 0.0 ;
float [] phase = new float[500];

city [] cities;
void setup(){
  size(900,600);
  background(255);
  frameRate(120);
  sea(sHeight);
  cities = new city[ncities];
  String [] cnames = loadStrings("./data/cities.txt");
  for (int i=0;i<ncities;++i){
  
    cities[i] = new city(random(0.7)+ sHeight ,  random(popmax),cnames[i]);
    cities[i].show();
  }
  
  for(int i=0; i<500; ++i)
  phase[i] = random(TWO_PI);
  
}
void draw(){
  fill(255,190);
  rect(-0.001*width, -0.001*height,width*1.002,height*1.002);
  sea(sHeight);
  for (int i=0;i<ncities;++i){
    cities[i].changePop();  
}

  for (int i=0;i<ncities;++i){
    cities[i].feedPop();
    cities[i].show();
}

notsub = 0;
popChange = 0.0;
}

void mousePressed() {
    //sHeight = 1- mouseY/(1.0*height);
    //sHeight =  map(1-mouseY/(1.0*height), 0, 1, 0, 0.4);
} 

void mouseDragged() {
    //sHeight = 1- mouseY/(1.0*height);
    if(mouseY>height*0.5) 
    sHeight = 1- mouseY/(1.0*height);
    //sHeight =  map(1-mouseY/(1.0*height), 0, 1, 0, 0.4);
} 

  
