<<<<<<< HEAD
// figure out the way to quantify the drowning. 
=======
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
void sea(float h){
  color wcol = #219ebc;
  fill(wcol);
  //noStroke();
  //rect(0,height*(1-h) ,width, h*height);
  
  int N = 100;
  float [] xvec = new float[N];
  for(int i=0; i<N; ++i){
    xvec[i] = map(i,0,N,0,TWO_PI*1.8);
  }
   
  float ht = 0;
  //noFill();
  stroke(wcol);
<<<<<<< HEAD
  fill(wcol,80);
  int cc=0;
  float waveamp = 0.02*width;
=======
  fill(wcol,20);
  int cc=0;
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
  //strokeWeight(5);
  while(ht<h) {
    beginShape();
    for(int i=0; i<N; ++i)
<<<<<<< HEAD
      curveVertex( -50 + i*(width*1.25)/N, sin( xvec[i] + frameCount*0.005 + phase[cc])*waveamp+ (1-ht)*height );
    curveVertex( width*1.2, height*1.5 );
    curveVertex( -100, height*1.5 );
    curveVertex( -100, sin( xvec[0] + frameCount*0.005 + phase[cc])*waveamp+ (1-ht)*height );
    endShape();
    ht += 5.0/height;
=======
      curveVertex( -50 + i*(width*1.25)/N, sin( xvec[i] + frameCount*0.005 + phase[cc])*25 + (1-ht)*height );
    curveVertex( width*1.2, height*1.5 );
    curveVertex( -100, height*1.5 );
    curveVertex( -100, sin( xvec[0] + frameCount*0.005 + phase[cc])*25 + (1-ht)*height );
    endShape();
    ht += 10.0/height;
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
    cc++;
  }
  
}




class city{
<<<<<<< HEAD
  PVector loc;
  float size, size0,pop,h,pop0;
  color cc;
  String name;
  int sub; // -1 -> no! 0 -> currently submerging. 1 -> yes .
  
  city(float h1,float pop1,String name1){
    h = h1;
    name = name1;
    pop = pop1;
    pop0 = pop;
    float y = 1-h;
    float x = tan(theta)*y + 0.05 + randomGaussian()*0.24;
=======
  float h;
  PVector loc;
  float size, size0;
  color cc;
  float pop;
  int sub; // -1 -> no! 0 -> currently submerging. 1 -> yes .
  
  city(float h1,float pop1){
    h = h1;
    pop = pop1;
    float y = 1-h;
    float x = tan(theta)*y + 0.05 + randomGaussian()*0.1;
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
    loc = new PVector (x*width,y*height);
    size = 2*(0.01 + 0.04*pop/popmax)*width  ;
    size0 = size;
    cc = lerpColor(c1,c2,pop/popmax); 
    sub = -1; 
<<<<<<< HEAD
    println(name);
=======
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
  }
  
  void show(){
    fill(cc);
    noStroke();
<<<<<<< HEAD
    // println(pop0,pop);
    circle(loc.x ,loc.y,size*(1 + 0.08*sin(frameCount*0.03 * pow(pop/pop0,3)))); 
=======
    circle(loc.x ,loc.y,size*(1 + 0.1*sin(frameCount*0.06))); 
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
    
    noFill();
    strokeWeight(1);
    stroke(0);
    circle( loc.x, loc.y, size0 );
<<<<<<< HEAD
    
    float txtsize = 0.05*width/4;
    fill(10);
    textSize(txtsize);
    text(name,loc.x+size0/2*1.5, loc.y+txtsize/2);
=======
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
  }
  void changePop(){
    if (sHeight > h){
      size = 0.0;
      sub  = 1;
    }
    else if(sHeight*height > (h*height - size/2)){
      float ratio = 2*(h-sHeight)*height/size;
      popChange = popChange -  (ratio-1)*pop;
<<<<<<< HEAD
      // println(popChange);
=======
      println(popChange);
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 0e0ed072d0774629e6efd3ba9a7a0e93bf9d6c53
