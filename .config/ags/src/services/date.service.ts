type DateFormat = {
  hour: string;
  minute: string;
  second: string;
  weekday: string;
  day: string;
  month_number: string;
  month: string;
  year: string;
}

class DateService extends Service {
  static {
    Service.register(this, {}, { 'date': ['jsobject'] });
  }

  private readonly UPDATE_TIME: number = 10_000;

  #date: DateFormat = { hour: '', minute: '', second: '', weekday: '', day: '', month_number: '', month: '', year: '', };

  get date(): DateFormat { return this.#date; }

  constructor() {
    super();
    Utils.interval(this.UPDATE_TIME, () => this.#update());
  }

  async #update() {
    this.#date = this.#toFormat(await Utils.execAsync('date "+%H %M %S %a %d %b %m %Y"'));
    this.changed('date');
  }

  #toFormat(execOutput: string): DateFormat {
    const [hour, minute, second, weekday, day, month, month_number, year] = execOutput.split(" ");
    return {
      hour: hour.padStart(2, "0") ?? '',
      minute: minute.padStart(2, "0") ?? '',
      second: second.padStart(2, "0") ?? '',
      weekday: weekday ?? '',
      day: day ?? '',
      month_number: month_number ?? '',
      month: month ?? '',
      year: year ?? '',
    };
  }
}

export default new DateService;


// import { Binding as TypeBinding } from "types/service";
// import { Variable as TypeVariable } from "types/variable";
//
// interface DateServiceInterface {
//   date: TypeVariable<string>;
//   bind: TypeBinding<TypeVariable<string>, "is_listening" | "is_polling" | "value", DateFormat>;
//   get HM(): BindingAsString;
//   get HMS(): BindingAsString;
//   get HMa(): BindingAsString;
//   get dby(): BindingAsString;
// }
//
// type BindingAsString = TypeBinding<TypeVariable<string>, "is_listening" | "is_polling" | "value", string>;
//
// interface DateFormat {
//   hour: string;
//   minute: string;
//   second: string;
//   weekday: string;
//   day: string;
//   month_number: string;
//   month: string;
//   year: string;
// }
//
//
// class DateService implements DateServiceInterface {
//   date: DateServiceInterface['date'] = Variable("", { poll: [10_000, 'date "+%H %M %S %a %d %b %m %Y"'] });
//   bind: DateServiceInterface['bind'];
//
//   constructor() {
//     this.bind = this.date.bind().as(this.format);
//   }
//
//   get HM(): DateServiceInterface['HM'] {
//     return this.bind.as(date => `${date.hour}:${date.minute}`);
//   }
//   get HMS(): DateServiceInterface['HMS'] {
//     return this.bind.as(date => `${date.hour}:${date.minute}:${date.second}`);
//   }
//   get HMa(): DateServiceInterface['HMa'] {
//     return this.bind.as(date => `${date.weekday} ${date.hour}:${date.minute}`);
//   }
//   get dby(): DateServiceInterface['dby'] {
//     return this.bind.as(date => `${date.day}.${date.month_number}.${date.year}`);
//   }
//
//   private format(date_value: DateServiceInterface['date']['value']): DateFormat {
//     const [hour, minute, second, weekday, day, month, month_number, year] = date_value.split(" ");
//     return {
//       hour: hour.padStart(2, "0"),
//       minute: minute.padStart(2, "0"),
//       second: second.padStart(2, "0"),
//       weekday,
//       day,
//       month_number,
//       month,
//       year,
//     };
//   }
// }
//
// const dateService = new DateService();
// export default dateService;

