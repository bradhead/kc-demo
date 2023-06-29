FROM smilecdr:2023.05.R02

RUN mkdir /home/smile/smilecdr/activemq-data
RUN mkdir /home/smile/smilecdr/database
RUN mkdir /home/smile/smilecdr/log
RUN mkdir /home/smile/smilecdr/tmp
RUN chown -R smile:smile /home/smile/smilecdr/activemq-data
RUN chown -R smile:smile /home/smile/smilecdr/database
RUN chown -R smile:smile /home/smile/smilecdr/log
RUN chown -R smile:smile /home/smile/smilecdr/tmp
RUN chmod 775 /home/smile/smilecdr/activemq-data
RUN chmod 775 /home/smile/smilecdr/database
RUN chmod 775 /home/smile/smilecdr/log
RUN chmod 775 /home/smile/smilecdr/tmp