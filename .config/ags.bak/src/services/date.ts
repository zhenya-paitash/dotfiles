const DATE = Variable('', { poll: [10_000, 'date "+%H %M %S %a %d %b %m %Y"'] });

export const DATE_HMa = DATE.bind().as(date => {
  const [hour, minute, _, weekday] = date.split(" ");
  return `${weekday} ${hour}:${minute}`;
});

export const DATE_dbY = DATE.bind().as(date => {
  const [h, m, s, a, day, mn, month, year] = date.split(" ");
  return `${day}.${month}.${year}`;
});
