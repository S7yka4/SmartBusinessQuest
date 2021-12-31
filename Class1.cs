using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp9
{
    struct TypeOfTransmission
    {
        //код описывающий тип коробки передач 
    }
    abstract class Car//абстрактный класс машины содержит общие поля
    {
        public double VolumeOfEngine;
        public double Power;
    }

    class PassengerCar:Car//легковая машина
    {
        public TypeOfTransmission Type_Of_Transmission;

    }

    class CargoCar:Car//грузовая машина
    {
        public double LiftingCapacity;
    }
}
