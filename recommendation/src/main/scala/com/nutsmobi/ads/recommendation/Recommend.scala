package com.nutsmobi.ads.recommendation

import org.apache.spark.SparkConf
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Minutes, Seconds, StreamingContext}

/**
  *
  * Consumes messages from one or more topics in Kafka and does wordcount.
  * Usage: KafkaWordCount <zkQuorum> <group> <topics> <numThreads>
  *   <zkQuorum> is a list of one or more zookeeper servers that make quorum
  *   <group> is the name of kafka consumer group
  *   <topics> is a list of one or more kafka topics to consume from
  *   <numThreads> is the number of threads the kafka consumer should use
  *
  * Example:
  *    `$ bin/run-example \
  *      org.apache.spark.examples.streaming.KafkaWordCount zoo01,zoo02,zoo03 \
  *      my-consumer-group topic1,topic2 1`
  *
  * Usage:
  *     `$ bin/run.sh `
  * Author: Noprom <tyee.noprom@qq.com>
  * Date: 11/10/2016 2:41 PM.
  */
object Recommend {

  case class UserClick(userId: String, adsId: String, click: Int)

  def parseUserClick(line: String): List[UserClick] = {
    val rawJson = line.split("|")(2)


    // TODO: add actual user clicks
    val userClick = UserClick("noprom", "noprom-ad", 5)
    List(userClick)
  }

  def main(args: Array[String]) {
    println("args.length = " + args.length)
    println("args:")
    args.foreach(println)
    println("...")
    if (args.length < 4) {
      System.err.println("Usage: Recommend <zkQuorum> <group> <topics> <numThreads>")
      System.exit(1)
    }

    //StreamingExamples.setStreamingLogLevels()

    val Array(zkQuorum, group, topics, numThreads, jarName) = args
    val sparkConf = new SparkConf().setAppName("Nuts ADs Recommendation")
    val ssc = new StreamingContext(sparkConf, Seconds(2))
    ssc.checkpoint("checkpoint")

    val topicMap = topics.split(",").map((_, numThreads.toInt)).toMap

    val lines = KafkaUtils.createStream(ssc, zkQuorum, group, topicMap).map(_._2)

    // Extract user and item
    val json = lines.flatMap(parseUserClick)

    // For debug
//    val words = lines.flatMap(_.split(" "))
//    val wordCounts = words.map(x => (x, 1L))
//      .reduceByKeyAndWindow(_ + _, _ - _, Minutes(10), Seconds(2), 2)
//    wordCounts.print()

    ssc.start()
    ssc.awaitTermination()
  }
}
