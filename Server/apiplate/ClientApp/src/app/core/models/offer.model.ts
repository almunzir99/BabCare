import { Base } from "./base.model";
import { Image } from "./image.model";

export class Offer extends Base {
    title:string;
    image:Image;
    discount:number;
    startDate:Date;
    endDate:Date;
}