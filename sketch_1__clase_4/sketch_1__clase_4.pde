void setup(){
  size(800,800);
  background(0);
  noStroke();
  fill(255);
  
  for(int x=0; x<width;  x= x + 50){
    print(x);
   ellipse(x,50,20,20);
    //x=x+50;
    
}
}
