// figure out the way to quantify the drowning. 
void sea(float h){
  color wcol = #219ebc;
  fill(wcol);
  // noStroke();
  // rect(0,height*(1-h) ,width, h*height);
  
  int N = 50;
  float [] xvec = new float[N];
  for(int i=0; i<N; ++i){
    xvec[i] = map(i,0,N,0,TWO_PI*1.8);
  }
   
  float ht = 0;
  //noFill();
  stroke(wcol);
  fill(wcol,30);
  int cc=0;
  float waveamp = 0.02*width;
  
  //strokeWeight(5);
  while(ht<h) {
    float speed = frameCount*((0.01));//+random(0,0.013)));
    beginShape();
    for(int i=0; i<N; ++i)
      curveVertex( -100 + i*(width*1.25)/N, sin( xvec[i] + speed + phase[cc])*waveamp+ (1-ht)*height );
    curveVertex( width*1.2, height*1.5 );
    curveVertex( -100, height*1.5 );
    curveVertex( -100, sin( xvec[0] + frameCount*0.013 + phase[cc])*waveamp+ (1-ht)*height );
    endShape();
    ht += 20.0/height;
    cc++;
  }
  
    float lblsize = 0.0202*width;
    fill(10);
    textSize(lblsize);
    String txt = "SLR : " + nf(h - sHeight0,1,2);
    text(txt,width - textWidth(txt)*1.5 , (1- h )*height-waveamp*1.1 );
    textSize(lblsize*0.7);
    text("mm", width - textWidth(txt)*0.5/0.7 , (1- h)*height -waveamp*1.1);
}

void resetbtn(){
  fill(#8d99ae);
  noStroke();
  rect(rstPosx*width, rstPosy*height, rstlen*width, rstbreadth*height);
  
  stroke(0);
  fill(10);
  textSize(rstTxtsize);
  text("Reset",rstPosx*width+rstlen*width/2 - rstTxtsize, rstPosy*height+rstbreadth*height/1.5);
}


class HScrollbar {
  float swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  // float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, float sw, float sh, int l) {
    swidth = sw*width;
    sheight = sh*height;
    float widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp*width;
    ypos = (yp*height-sheight/2);
    spos = xpos;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }
  void lbl()  {
    float lblsize = 0.0202*width;
    fill(10);
    String tx1 = "CO\u2082";
    String tx2 = nf(map(spos, sposMin,sposMax, 0,1),1,2) ;
    textSize(lblsize);
    text(tx1,xpos- textWidth(tx1)*1.1, ypos + sheight/1.25);
    text(tx2 ,xpos +lblsize +swidth, ypos + sheight/1.25   );
    textSize(lblsize*0.7);
    text("ppm",xpos +lblsize +swidth + textWidth(tx2)*1.5, ypos + sheight/1.5   );
  }
  void update() {
    overEvent();
    if (firstMousePress && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 0.1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  void overEvent() {
    // println(spos,mouseX,spos + sheight);
    if (mouseX > spos && mouseX < spos+sheight &&
      mouseY > ypos && mouseY < ypos+sheight) {
      over = true;
    } else {
      over = false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    
    rect(xpos+sheight/2, ypos+sheight/2 -  sheight/10, swidth-sheight, sheight/5);
    // fill(204);
    // ellipse(xpos+sheight/2, ypos+sheight/2, sheight,sheight);
    // fill(204);
    // ellipse(swidth-sheight/2, ypos+sheight/2, sheight);
    if (over || locked) {
      fill(0, 0, 0);
      ellipse(spos+sheight/2, ypos+sheight/2, sheight*1.2  , sheight*1.2);
    } else {
      fill(102, 102, 102);
      ellipse(spos+sheight/2, ypos+sheight/2, sheight*0.9,sheight*0.9);
    }
    
  }
  void reset(){
    spos = xpos ;
    newspos = spos;
  }
  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos;
  }
}

float Co2ToSheight(float co2){
  return 1.622077566762639*co2 + -615.265192094049;
}
class city{
  PVector loc;
  float size, size0,pop,h,pop0;
  color cc;
  String name;
  int i, sub; // -1 -> no! 0 -> currently submerging. 1 -> yes .
  
  city(float h1,int i1, float pop1,String name1){
    h = h1;
    i  =i1 ;
    name = name1;
    pop = pop1;
    pop0 = pop;
    float y = 1-h;
    // float x = tan(theta)*y + 0.05 + randomGaussian()*0.24;
    float x =0.05*width+  random(colwidth*i*1.1, 0.9*colwidth*(i+1));
    // println(x/width);
    loc = new PVector (x,y*height);
    size = 2*(0.01 + 0.04*pop/popmax)*width  ;
    size0 = size;
    cc = lerpColor(c1,c2,pop/popmax); 
    sub = -1; 
    // println(name);
    // println(name.length()/2);
  }
  
  void show(){
    fill(cc);
    noStroke();
    // println(pop0,pop);
    // if (name == "City 2")
    // println(size + size0*0.08*sin(frameCount*0.03 * pow(pop/pop0,4)));
    // if (i == 3){
    // println(name,   sin(frameCount*0.03));
    // }
    ellipse(loc.x ,loc.y,size + size0*0.08*sin(frameCount*0.02* pow(pop/pop0,4) ),size + size0*0.08*sin(frameCount*0.02* pow(pop/pop0,4) )); 
    
    noFill();
    strokeWeight(1);
    stroke(0);
    ellipse( loc.x, loc.y, size0,size0 );
    
    float txtsize = 0.08*width/4;
    
    fill(10);
      textSize(txtsize);
      text(name,loc.x -txtsize , loc.y-(txtsize/4 +size0/2*1.5));
    }
  void changePop(){
    if (sHeight > h){
      popChange = popChange + pop;
      size = 0.0;
      sub  = 1;
      pop = 0.0;
    }
    else if(sHeight*height > (h*height - size/2)){
      float ratio = 2*(h-sHeight)*height/size;
      popChange = popChange -  (ratio-1)*pop;
      // println(popChange);
      pop = pop*ratio;
      cc =  lerpColor(c1,c2,pop/popmax);
      sub = 0;
      size = 2*(h-sHeight)*height;
    }else {
      notsub = notsub + 1;
    }
    
  }
  
  void feedPop(){
   if (sub <0){
     pop = pop + popChange/(1.0*notsub);
     cc =  lerpColor(c1,c2,pop/popmax);
     size = 2*(0.01 + 0.04*pop/popmax)*width;
     //println("Exists");     
   }    
  }
  void reset(){
    if (reset){
      // print("YAY!!");
      size = size0;
      pop = pop0;
      cc = lerpColor(c1,c2,pop/popmax);
      sub = -1;
    }
  }

}