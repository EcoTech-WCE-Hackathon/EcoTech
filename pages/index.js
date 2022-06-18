import Head from "next/head";
import Image from "next/image";

export default function Home() {
  return (
    <div>
      <Head>
        <title>Admin | EchoTech</title>
        <meta name="description" content="Admin Website for Echotech" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <h1 className="text-3xl text-green-500 font-bold">Hello WCE Hackathon</h1>
    </div>
  );
}
