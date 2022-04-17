import { Base } from "./base.model";


export interface ApiNotification extends Base {
    title: string;
    message: string;
    action: string;
    module: string;
    url: string;
    read: boolean;
    groupedItem: number | null;
}