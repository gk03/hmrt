import g4p_controls.*;
import org.firmata.*;
import cc.arduino.*;
import procontroll.*;
import java.io.*;
import processing.serial.*;

ControllIO controll;
ControllDevice device;
ControllStick stick,stick1;
ControllButton butt1,but0,but1,but2,but3,but4,but5,but6,but7,but8,but9,but10,but11;
Arduino arduino;
Serial myport;

int lout1=52,lout2=53,lpwn=4;
int rout1=50,rout2=51,rpwn=3;
int statu=0;
float x,y,x1,x2,y1,y2;
int stop;


int dir1=32,pwm1=13;
int dir2=33,pwm2=12;
int dir3=34,pwm3=11;
int dir4=35,pwm4=10;
int dir5=36,pwm5=9;
int dir6=37,pwm6=8;
float X1,Y1;

//-------------------------------- below for map 

import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

import javax.swing.JFrame;

PFrame f;
secondApplet s;

UnfoldingMap map;
CompassUI compass;


 // --------------------------------------------------------------------- check below
int latpin= ???
int lonpin= ???




public void setup(){
  size(480, 320, JAVA2D);
    PFrame f = new PFrame();
  createGUI();
  customGUI();
  // Place your setup code here
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(lout1, Arduino.OUTPUT);
  arduino.pinMode(lout2, Arduino.OUTPUT);
  arduino.pinMode(lpwn, Arduino.OUTPUT);
  arduino.pinMode(rout1, Arduino.OUTPUT);
  arduino.pinMode(rout2, Arduino.OUTPUT);
  arduino.pinMode(rpwn, Arduino.OUTPUT);
  
    arduino.pinMode(dir1, Arduino.OUTPUT);
  arduino.pinMode(pwm1, Arduino.OUTPUT);
  arduino.pinMode(dir2, Arduino.OUTPUT);
  arduino.pinMode(pwm2, Arduino.OUTPUT);
  arduino.pinMode(dir3, Arduino.OUTPUT);
  arduino.pinMode(pwm3, Arduino.OUTPUT);
  arduino.pinMode(dir4, Arduino.OUTPUT);
  arduino.pinMode(pwm4, Arduino.OUTPUT);
  arduino.pinMode(dir5, Arduino.OUTPUT);
  arduino.pinMode(pwm5, Arduino.OUTPUT);
  arduino.pinMode(dir6, Arduino.OUTPUT);
  arduino.pinMode(pwm6, Arduino.OUTPUT);
  
    controll = ControllIO.getInstance(this);
    
  ControllDevice device = controll.getDevice(3)
  ;
  device = controll.getDevice(device.getName());
  
  ControllDevice device1 = controll.getDevice(2);
  device1 = controll.getDevice(device1.getName());
 
  
  device.setTolerance(0.05f);
  
  ControllSlider sliderX = device.getSlider("X Axis");
  ControllSlider sliderY = device.getSlider("Y Axis");
  
  stick = new ControllStick(sliderX,sliderY);

  
  butt1 = device.getButton("Button 0");
  
  
  but0 = device1.getButton("Button 0");
  but1 = device1.getButton("Button 1");
  but2 = device1.getButton("Button 2");
  but3 = device1.getButton("Button 3");
  but4 = device1.getButton("Button 4");
  but5 = device1.getButton("Button 5");
  but6 = device1.getButton("Button 6");
  but7 = device1.getButton("Button 7");
  but8 = device1.getButton("Button 8");
  but9 = device1.getButton("Button 9");
  but10 = device1.getButton("Button 10");
  but11 = device1.getButton("Button 11");
  

}

public void draw(){
  background(230);  
  x=stick.getX();
  y=stick.getY();
  x1=x*10;
  y1=y*10;
  y2=map(y1,0,10,0,255);
  y2=y2*(-1);
  int y3=round(y2);
  x2=map(x1,0,10,0,255);
  x2=x2*(-1);
  int x3=round(x2);

   if(butt1.pressed())
  {  stop=1;
    if(statu==1)
 {
   println("stoped");
   arduino.digitalWrite(lout1, Arduino.HIGH);
   arduino.digitalWrite(lout2, Arduino.HIGH);
   arduino.analogWrite(lpwn, 0);
   arduino.digitalWrite(rout1, Arduino.HIGH);
   arduino.digitalWrite(rout2, Arduino.HIGH);
   arduino.analogWrite(rpwn, 0);
    }
 else
 println("power is off");
  }
  
 else if(x>-0.5&&x<0.5&&y>0.5&&y<=1)
  {  stop=1;
     if(statu==1)
  { 
    y3=y3*(-1);
     arduino.digitalWrite(lout1, Arduino.LOW);
   arduino.digitalWrite(lout2, Arduino.HIGH);
   arduino.analogWrite(lpwn, y3);
    arduino.digitalWrite(rout1, Arduino.LOW);
   arduino.digitalWrite(rout2, Arduino.HIGH);
   arduino.analogWrite(rpwn, y3);
    
  
      println("moving back");
  }
  else
 println("power is off");
  }
  else if(x>-0.5&&x<0.5&&y>=-1&&y<-0.5)
  {  stop=1;
    if(statu==1)
 { 
 
   arduino.digitalWrite(lout1, Arduino.HIGH);
   arduino.digitalWrite(lout2, Arduino.LOW);
   arduino.analogWrite(lpwn, y3);
   arduino.digitalWrite(rout1, Arduino.HIGH);
   arduino.digitalWrite(rout2, Arduino.LOW);
   arduino.analogWrite(rpwn, y3); 
   
   println("moving front");
 }
 else
 println("power is off");
  }
 else if(x>=-1&&x<-0.5&&y>-0.5&&y<0.5)
  { stop=1;
    if(statu==1)
   { 
     
   arduino.digitalWrite(lout1, Arduino.LOW);
   arduino.digitalWrite(lout2, Arduino.HIGH);
   arduino.analogWrite(lpwn, x3);
   arduino.digitalWrite(rout1, Arduino.HIGH);
   arduino.digitalWrite(rout2, Arduino.LOW);
   arduino.analogWrite(rpwn, x3);
      println("moving left");
   }
   else
 println("power is off");
  }
  
  
 else if(x>0.5&&x<=1&&y<0.5&&y>-0.5)
  {  stop=1;
     if(statu==1)
 { 
   x3=x3*(-1);
   arduino.digitalWrite(lout1, Arduino.HIGH);
   arduino.digitalWrite(lout2, Arduino.LOW);
   arduino.analogWrite(lpwn, x3);
   arduino.digitalWrite(rout1, Arduino.LOW);
   arduino.digitalWrite(rout2, Arduino.HIGH);
   arduino.analogWrite(rpwn, x3);
      println("moving right");
 }
 else
 println("power is off");
  }
  
  
else 
{
  if(stop==1)
  {
    if(statu==1)
     {
       println("stoped");
       arduino.digitalWrite(lout1, Arduino.HIGH);
       arduino.digitalWrite(lout2, Arduino.HIGH);
       arduino.analogWrite(lpwn, 0);
       arduino.digitalWrite(rout1, Arduino.HIGH);
       arduino.digitalWrite(rout2, Arduino.HIGH);
       arduino.analogWrite(rpwn, 0);
     }
   else
   println("power is off");
     stop=0;
    }
    
  }
  
  if(but4.pressed())
  {
    arduino.digitalWrite(dir1, Arduino.HIGH);
    arduino.analogWrite(pwm1, 255); 
   println("gripper up"); 
  }
   else if(but5.pressed())
   {
      arduino.digitalWrite(dir1, Arduino.LOW);
      arduino.analogWrite(pwm1, 255);  
     println("gripper down"); 
   }
   else if(but6.pressed())
  {
      arduino.digitalWrite(dir6, Arduino.HIGH);
      arduino.analogWrite(pwm6, 255);
      println("base motor ");
  }
   else if(but7.pressed())
   {
      arduino.digitalWrite(dir6, Arduino.LOW);
      arduino.analogWrite(pwm6, 255);
      println("base motor ");
   }
   else if(but10.pressed())
   {
     arduino.digitalWrite(dir3, Arduino.HIGH);
     arduino.analogWrite(pwm3, 255); 
     println("hand");
   }
    else if(but11.pressed())
   {
      arduino.digitalWrite(dir3, Arduino.LOW);
      arduino.analogWrite(pwm3, 255);
    println("hand");  
   }
   else if(but0.pressed())
   {
     arduino.digitalWrite(dir4, Arduino.HIGH);
     arduino.analogWrite(pwm4, 255);
    println("accuator-2"); 
   }
    else if(but1.pressed())
   {
      arduino.digitalWrite(dir4, Arduino.LOW);
      arduino.analogWrite(pwm4, 255); 
     println("accuator-2"); 
   } 
   else if(but2.pressed())
   {
     arduino.digitalWrite(dir5, Arduino.HIGH);
     arduino.analogWrite(pwm5, 255); 
     println("accuator-1");
   }
    else if(but3.pressed())
   {
      arduino.digitalWrite(dir5, Arduino.LOW);
      arduino.analogWrite(pwm5, 255); 
     println("accuator-1"); 
   }
     else if(but8.pressed())
   {
      arduino.digitalWrite(dir2, Arduino.HIGH);
      arduino.analogWrite(pwm2, 255); 
     println("accuator-1 2nd hand");   
   }
   
    else if(but9.pressed())
   {
      arduino.digitalWrite(dir2, Arduino.LOW);
      arduino.analogWrite(pwm2, 255); 
     println("accuator-1 2nd hand");   
   }
   else
   {
      arduino.analogWrite(pwm1, 0);
      arduino.analogWrite(pwm2, 0);  
      arduino.digitalWrite(dir3, Arduino.HIGH);
      arduino.analogWrite(pwm3, 20);
      arduino.analogWrite(pwm4, 0);
      arduino.analogWrite(pwm5, 0);
      arduino.analogWrite(pwm6, 0);  
   }
   
   
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
 public class PFrame extends JFrame {
    public PFrame() {
        setBounds(100,100,400,300);
        s = new secondApplet();
        add(s);
        s.init();
        show();
    }
}
float lan,lat;
public class secondApplet extends PApplet {
    public void setup() { 
           size(400, 300);
           String tilesStr = sketchPath("data/map.mbtiles");
           map = new UnfoldingMap(this, new MBTilesMapProvider(tilesStr));
           MapUtils.createDefaultEventDispatcher(this, map);
           compass = new CompassUI(this,map);
             
            arduino.pinMode(latpin, Arduino.INPUT);
            arduino.pinMode(lonpin, Arduino.INPUT);
    }
    public void draw() {
        lan =  arduino.analogRead(lanpin);
        lat =  arduino.analogRead(latpin);
        Location myLocation = new Location(lan, lat); // put the longitude and latitude here...
        SimplePointMarker myMarker = new SimplePointMarker(myLocation);
        map.addMarkers(myMarker);
        map.zoomAndPanTo(myLocation, 17); // -------------------- change the zoom value here lik 17 / 18 / 19
        myMarker.setColor(color(255, 0, 0, 100));
        myMarker.setStrokeColor(color(255, 0, 0));
        myMarker.setStrokeWeight(4);
        map.draw();
        
    }
}
